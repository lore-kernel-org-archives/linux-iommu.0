From: valmiki <valmikibow-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Support SVM without PASID
Date: Wed, 12 Jul 2017 21:53:25 +0530
Message-ID: <2eef6af5-0285-fade-6c17-fad38586f4f0@gmail.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
	<20170708140257.2de02d63@w520.home>
	<73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
	<20170710193141.GA3813@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170710193141.GA3813-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 7/11/2017 1:01 AM, Jerome Glisse wrote:
> On Sun, Jul 09, 2017 at 08:45:57AM +0530, valmiki wrote:
>>>> Hi,
>>>>
>>>> In SMMUv3 architecture document i see "PASIDs are optional,
>>>> configurable, and of a size determined by the minimum
>>>> of the endpoint".
>>>>
>>>> So if PASID's are optional and not supported by PCIe end point, how SVM
>>>> can be achieved ?
>>>
>>> It cannot be inferred from that statement that PASID support is not
>>> required for SVM.  AIUI, SVM is a software feature enabled by numerous
>>> "optional" hardware features, including PASID.  Features that are
>>> optional per the hardware specification may be required for specific
>>> software features.  Thanks,
>>>
>> Thanks for the information Alex. Suppose if an End point doesn't support
>> PASID, is it still possible to achieve SVM ?
>> Are there any such features in SMMUv3 with which we can achieve it ?
>
> You can achieve SVM in software, this is what HMM is for. But the hardware
> must have an mmu with similar features as you get on CPU mmu. Device like
> GPU do have such MMU.
>
> You can also mix HMM with PASID/ATS to leverage device memory. HMM allows
> you to use device memory inside process address space for device threads
> (ie device memory is still consider as un-accessible from CPU, only device
> can access it). Again very useful for GPU.
>
Thanks Jerome, this is interesting and great work. Will try to explore 
more on this option.

Regards,
Valmiki
