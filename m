From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: Support SVM without PASID
Date: Wed, 12 Jul 2017 17:48:40 +0100
Message-ID: <ca0d9f94-f5e2-aaaf-2c64-0cd6ecc62754@arm.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
 <eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
 <ee41f5d9-e7fb-8f7c-4b85-87cdb951ec70@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <ee41f5d9-e7fb-8f7c-4b85-87cdb951ec70@gmail.com>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: valmiki <valmikibow@gmail.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, tianyu.lan@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com
List-Id: iommu@lists.linux-foundation.org

On 12/07/17 17:27, valmiki wrote:
> On 7/11/2017 4:26 PM, Jean-Philippe Brucker wrote:
>> Hi Valmiki,
>>
>> On 09/07/17 04:15, valmiki wrote:
>>>>> Hi,
>>>>>
>>>>> In SMMUv3 architecture document i see "PASIDs are optional,
>>>>> configurable, and of a size determined by the minimum
>>>>> of the endpoint".
>>>>>
>>>>> So if PASID's are optional and not supported by PCIe end point, how SVM
>>>>> can be achieved ?
>>>>
>>>> It cannot be inferred from that statement that PASID support is not
>>>> required for SVM.  AIUI, SVM is a software feature enabled by numerous
>>>> "optional" hardware features, including PASID.  Features that are
>>>> optional per the hardware specification may be required for specific
>>>> software features.  Thanks,
>>>>
>>> Thanks for the information Alex. Suppose if an End point doesn't support
>>> PASID, is it still possible to achieve SVM ?
>>> Are there any such features in SMMUv3 with which we can achieve it ?
>>
>> Not really, we don't plan to share the non-PASID context with a process.
>>
>> In theory you could achieve something resembling SVM by assigning the
>> entire endpoint to userspace using VFIO, then use ATS+PRI capabilities
>> with a bind ioctl. If your device can do SR-IOV, then you can bind one
>> process per virtual function.
>>
>> Unless we end up seeing lots of endpoints that implement PRI but not
>> PASID, I don't plan to add this to VFIO or SMMUv3.
>>
>> For a PCIe endpoint, the requirements for SVM are ATS, PRI and PASID
>> enabled. In addition, the SMMU should support DVM (broadcast TLB
>> maintenance) and must be compatible with the MMU (page sizes, output
>> address size, ASID bits...)
>>
> Thanks Jean.
> In SMMU document it was quoted as follows
> "When STE.S1DSS==0b10, a transaction without a SubstreamID is accepted and
> uses the CD of Substream 0. Under this configuration, transactions that
> arrive with SubstreamID 0 are aborted and an event recorded."
> 
> Is this mode supported in your previous series of SMMUv3 patches ?
> If it is supported is it achieved through VFIO ?

Yes, STE.S1DSS==0b10 is the only supported mode with my patches. And in
VFIO, the non-PASID context (CD 0) is managed with
VFIO_IOMMU_MAP/UNMAP_DMA ioctls, mirroring the current behavior for
devices that don't support PASID. All other CDs, with PASID > 0, are
managed via the new BIND ioctl.

Thanks,
Jean
