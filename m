From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 7/7] vfio/type1: return MSI geometry through
	VFIO_IOMMU_GET_INFO capability chains
Date: Tue, 10 May 2016 18:50:25 +0200
Message-ID: <57321151.7080609@linaro.org>
References: <1462362858-2925-1-git-send-email-eric.auger@linaro.org>
	<1462362858-2925-8-git-send-email-eric.auger@linaro.org>
	<5729E5BB.1030101@linaro.org> <20160509170312.06e9c4fe@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160509170312.06e9c4fe-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, eric.auger-qxv4g6HH51o@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/10/2016 01:03 AM, Alex Williamson wrote:
> On Wed, 4 May 2016 14:06:19 +0200
> Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> 
>> Hi Alex,
>> On 05/04/2016 01:54 PM, Eric Auger wrote:
>>> This patch allows the user-space to retrieve the MSI geometry. The
>>> implementation is based on capability chains, now also added to
>>> VFIO_IOMMU_GET_INFO.  
>>
>> If you prefer we could consider this patch outside of the main series
>> since it brings extra functionalities (MSI geometry reporting). In a
>> first QEMU integration we would live without knowing the MSI geometry I
>> think, all the more so I currently report an arbitrary number of
>> requested IOVA pages. The computation of the exact number of doorbells
>> to map brings extra complexity and I did not address this issue yet.
>>
>> It sketches a possible user API to report the MSI geometry based on the
>> capability chains, as you suggested some time ago. I am currently busy
>> drafting a QEMU integration.
> 
> How would the user know that reserved MSI mappings are requires or
> available without this?  Wouldn't the only option be for userspace to
> try to map something with the reserved MSI flag set and see if the
> kernel accepts it?
Well my first guess was that the (QEMU) virt machine using KVM/PCIe-MSI
passthrough could hardcode an arbitrary "large" iova size (currently 16
64kB pages in my QEMU integration). In case this is not sufficient for
mapping all host doorbells, we would see MSI allocation failing. In case
the need shows up, we could increase the value later on.
  That's not a very desirable programming model.  The
> arbitrary size is pretty ugly, but it at least makes for a consistent
> user interface.  Is it a functional issue if we overestimate the size
> or is it just a matter of wasting IOVA space?  Is there significant
> harm in making it obscenely large, like 1MB?
no just waste of IOVA space. To make it as transparent as possible for
virt machine I wanted to hide in the platform bus reserved IOVA.
  The reference counting and
> re-use of IOVA pages seems like we may often only be using a single
> IOVA page for multiple doorbells.  I guess I'm leaning towards defining
> the API even if the value is somewhat arbitrary because we'd rather have
> control of this rather than having the user guess and try to rope them
> back in later to use a kernel recommended value.  Thanks,

OK

Thanks

Eric
> 
> Alex
> 
