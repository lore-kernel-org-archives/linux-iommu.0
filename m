From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
Date: Wed, 29 Jan 2014 11:57:16 -0600
Message-ID: <52E940FC.9050602@amd.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
	<1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>
	<20140117110830.GW3471@alberich> <52E92842.3000001@amd.com>
	<CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com>
	<52E93360.1000904@amd.com> <20140129171611.GB13543@alberich>
	<52E939CB.1020705@amd.com>
	<20140129172932.GQ26622@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140129172932.GQ26622-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 1/29/2014 11:29 AM, Will Deacon wrote:
> On Wed, Jan 29, 2014 at 05:26:35PM +0000, Suravee Suthikulanit wrote:
>> On 1/29/2014 11:16 AM, Andreas Herrmann wrote:
>>> On Wed, Jan 29, 2014 at 11:59:12AM -0500, Suravee Suthikulanit wrote:
>>>> Actually, we are using 32 on the AMD system. So, do you think we can set
>>>> this to 32 instead?
>>>
>>> I think that's ok.
>>>
>>> But are we really talking about number of SMRs or number of StreamIDs
>>> per master device here? Ie. are you just having 32 SMRs for an SMMU on
>>> your AMD system or do you have master devices which have 32 StreamIDs?
>>>
>>> If it's just number of SMRs we don't need to modify this macro.
>>>
>>
>> I am referring to the case where each mmu-master can have upto 32 streamID.
>
> Crikey, how many SMRs do you have? Andreas and I have been struggling to
> write a decent allocator for those, so if you have any algorithms that don't
> require a quantum computer, we'd love to hear from you :)!
>
> Will
>

Are you talking about the __arm_smmu_alloc_bitmap()?

Currently, we have configured the each SMMU to have 32 SMRs and using 
15-bit streamID. However, we mostly have upto 32 streamID for each 
master, and most of the SMMU only have one master.  So it looks like the 
current logic should be ok.

Suravee
