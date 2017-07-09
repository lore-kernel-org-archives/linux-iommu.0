From: valmiki <valmikibow@gmail.com>
Subject: Re: Support SVM without PASID
Date: Sun, 9 Jul 2017 08:45:57 +0530
Message-ID: <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170708140257.2de02d63@w520.home>
Sender: linux-pci-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, jean-Philippe Brucker <jean-philippe.brucker@arm.com>, tianyu.lan@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com
List-Id: iommu@lists.linux-foundation.org

>> Hi,
>>
>> In SMMUv3 architecture document i see "PASIDs are optional,
>> configurable, and of a size determined by the minimum
>> of the endpoint".
>>
>> So if PASID's are optional and not supported by PCIe end point, how SVM
>> can be achieved ?
>
> It cannot be inferred from that statement that PASID support is not
> required for SVM.  AIUI, SVM is a software feature enabled by numerous
> "optional" hardware features, including PASID.  Features that are
> optional per the hardware specification may be required for specific
> software features.  Thanks,
>
Thanks for the information Alex. Suppose if an End point doesn't support
PASID, is it still possible to achieve SVM ?
Are there any such features in SMMUv3 with which we can achieve it ?

Regards,
valmki
