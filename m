From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v8 1/2] iommu - Enable debugfs exposure of IOMMU driver
	internals
Date: Tue, 12 Jun 2018 13:39:04 -0500
Message-ID: <bfee19e5-7953-7bda-2c46-9dbb4d002512@amd.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
	<152761819480.2654.5371070582955429468.stgit@sosgrh1.amd.com>
	<20180529184101.GB10618@kroah.com>
	<3249cc11-09d8-2078-28a6-efd3078ca0e9@amd.com>
	<20180605170824.GA11965@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180605170824.GA11965-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/05/2018 12:08 PM, Greg KH wrote:
> On Tue, Jun 05, 2018 at 12:01:41PM -0500, Gary R Hook wrote:
>>>> +/**
>>>> + * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
>>>> + * @vendor: name of the vendor-specific subdirectory to create
>>>> + *
>>>> + * This function is called by an IOMMU driver to create the top-level debugfs
>>>> + * directory for that driver.
>>>> + *
>>>> + * Return: upon success, a pointer to the dentry for the new directory.
>>>> + *         NULL in case of failure.
>>>> + */
>>>> +struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
>>>> +{
>>>> +	struct dentry *d_new;
>>>> +
>>>> +	d_new = debugfs_create_dir(vendor, iommu_debugfs_dir);
>>>> +
>>>> +	return d_new;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
>>>
>>> Why are you wrapping a debugfs call?  Why not just export
>>> iommu_debugfs_dir instead?
>>
>> It was a choice, as I stated in my other post. It is not a requirement.
>> If you resolutely reject this approach, that's fine. I'll change it, no
>> worries.
> 
> Either is fine, but if it stays, it should stay a single line function
> :)
> 
> thanks,
> 
> greg k-h
> 

Then I shall leave it as a black-box function. Single line, of course.

Thank you.
