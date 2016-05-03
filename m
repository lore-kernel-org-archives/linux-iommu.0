From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 6/8] iommu/msi-iommu: iommu_msi_domain
Date: Tue, 3 May 2016 14:27:08 +0200
Message-ID: <5728991C.5060807@linaro.org>
References: <1461831323-5480-1-git-send-email-eric.auger@linaro.org>
	<1461831323-5480-7-git-send-email-eric.auger@linaro.org>
	<20160428162740.28db4b8d@t450s.home> <572776BD.2080503@linaro.org>
	<20160502142328.2d97f7a4@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160502142328.2d97f7a4-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, eric.auger-qxv4g6HH51o@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Alex,
On 05/02/2016 10:23 PM, Alex Williamson wrote:
> Hi Eric,
> 
> On Mon, 2 May 2016 17:48:13 +0200
> Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> 
>> Hi Alex,
>> On 04/29/2016 12:27 AM, Alex Williamson wrote:
>>> On Thu, 28 Apr 2016 08:15:21 +0000
>>> Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>>   
>>>> This function checks whether
>>>> - the device belongs to a non default iommu domain
>>>> - this iommu domain requires the MSI address to be mapped.
>>>>
>>>> If those conditions are met, the function returns the iommu domain
>>>> to be used for mapping the MSI doorbell; else it returns NULL.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>
>>>> ---
>>>>
>>>> v7 -> v8:
>>>> - renamed  iommu_msi_mapping_desc_to_domain to iommu_msi_domain
>>>> - the function now takes a struct device *
>>>> - use DOMAIN_ATTR_MSI_GEOMETRY attribute
>>>> ---
>>>>  drivers/iommu/msi-iommu.c | 17 +++++++++++++++++
>>>>  include/linux/msi-iommu.h | 14 ++++++++++++++
>>>>  2 files changed, 31 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/msi-iommu.c b/drivers/iommu/msi-iommu.c
>>>> index 203e86e..023ff17 100644
>>>> --- a/drivers/iommu/msi-iommu.c
>>>> +++ b/drivers/iommu/msi-iommu.c
>>>> @@ -243,3 +243,20 @@ unlock:
>>>>  	}
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(iommu_msi_put_doorbell_iova);
>>>> +
>>>> +struct iommu_domain *iommu_msi_domain(struct device *dev)
>>>> +{
>>>> +	struct iommu_domain *d = iommu_get_domain_for_dev(dev);
>>>> +	struct iommu_domain_msi_geometry msi_geometry;
>>>> +
>>>> +	if (!d || (d->type == IOMMU_DOMAIN_DMA))
>>>> +		return NULL;
>>>> +
>>>> +	iommu_domain_get_attr(d, DOMAIN_ATTR_MSI_GEOMETRY, &msi_geometry);
>>>> +	if (!msi_geometry.programmable)  
>>>
>>> It feels like we're conflating ideas with using the "programmable" flag
>>> in this way.  AIUI the IOMMU API consumer is supposed to see the
>>> invalid MSI geometry with the programmable feature set and know to call
>>> iommu_msi_set_aperture().  Looking for the msi_cookie would tell us if
>>> that had been done, but that doesn't tell us if it should have been
>>> done.  iommu_msi_msg_pa_to_va() handles this later, if we return
>>> NULL here that function returns success otherwise it goes on to fail if
>>> the iova or msi cookie is not set.  So really what we're trying to flag
>>> is that the MSI geometry participates in the IOMMU-MSI API you've
>>> created and we should pick a feature name that says that rather than
>>> something as vague a "programmable".  Perhaps simply iommu_msi_api
>>> rather than programmable.  
>> Yes I had the same questioning too when I wrote this code. So if my
>> understanding is correct we would have
>> - programmable: tells whether the MSI range is fixed or pogrammable and,
>> - mapping_required (new boolean field): indicating whether MSIs need to
>> be mapped in the IOMMU
> 
> Let's say we had a flag "iommu_msi_supported", doesn't that already
> tell us whether the MSI range is programmable and the API to use to do
> it?  Can't we figure out if mapping is required based on whether
> iommu_msi_supported is set and aperture_start and aperture_end indicate
> a valid range?  It seems like what we want on this code path is to
> simply know whether the IOMMU domain is relevant to the IOMMU MSI API,
> which would be abundantly clear with such a flag.
OK I now get your point. Thanks for the clarification. I renamed
programmable into iommu_msi_supported.
> 
>>>
>>> BTW, I don't see that you ever set aperture_start/end once
>>> iommu_msi_set_aperture() has been called.  It seems like doing so would
>>> add some consistency to that MSI geometry attribute.  
>> Indeed currently I mentionned:
>> /* In case the aperture is programmable, start/end are set to 0 */
> 
> Which is confusing, if a user sets an aperture, I would think they'd
> like to see the MSI geometry updated to reflect that.
> 
>> If I set start/end in iommu_msi_set_aperture then I think I should also
>> return the actual values in iommu_domain_get_attr. I thought the extra
>> care to handle the possible race between the set_aperture (msi_iommu)
>> and the get_attr (iommu) was maybe not worth the benefits:
>> is_aperture_set is not visible to get_attr so I would be forced to
>> introduce a mutex at iommu_domain level or call an msi-iommu function
>> from iommu implementation. So I preferred to keep start/end as read-only
>> info initialized by the iommu driver.
> 
> Seems like a race between iommu_msi_set_aperture() and
> iommu_domain_get_attr() is the caller's problem.  We can always define
> that start >= end is invalid and set them in the right order that
> iommu_domain_get_attr() may get different versions of invalid, but it
> will always be invalid or valid.  A helper function could tell us if we
> have a valid range rather than using is_aperture_set.  Thanks,


Agreed; I added an iommu_domain_msi_aperture_valid helper function.

Thanks!

Eric
> 
> Alex
> 
