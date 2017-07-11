From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Support SVM without PASID
Date: Tue, 11 Jul 2017 11:56:16 +0100
Message-ID: <eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
	<20170708140257.2de02d63@w520.home>
	<73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <73619426-6fcc-21ce-cfd4-8c66bde63f9a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: valmiki <valmikibow-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Valmiki,

On 09/07/17 04:15, valmiki wrote:
>>> Hi,
>>>
>>> In SMMUv3 architecture document i see "PASIDs are optional,
>>> configurable, and of a size determined by the minimum
>>> of the endpoint".
>>>
>>> So if PASID's are optional and not supported by PCIe end point, how SVM
>>> can be achieved ?
>>
>> It cannot be inferred from that statement that PASID support is not
>> required for SVM.  AIUI, SVM is a software feature enabled by numerous
>> "optional" hardware features, including PASID.  Features that are
>> optional per the hardware specification may be required for specific
>> software features.  Thanks,
>>
> Thanks for the information Alex. Suppose if an End point doesn't support
> PASID, is it still possible to achieve SVM ?
> Are there any such features in SMMUv3 with which we can achieve it ?

Not really, we don't plan to share the non-PASID context with a process.

In theory you could achieve something resembling SVM by assigning the
entire endpoint to userspace using VFIO, then use ATS+PRI capabilities
with a bind ioctl. If your device can do SR-IOV, then you can bind one
process per virtual function.

Unless we end up seeing lots of endpoints that implement PRI but not
PASID, I don't plan to add this to VFIO or SMMUv3.

For a PCIe endpoint, the requirements for SVM are ATS, PRI and PASID
enabled. In addition, the SMMU should support DVM (broadcast TLB
maintenance) and must be compatible with the MMU (page sizes, output
address size, ASID bits...)

Thanks,
Jean
