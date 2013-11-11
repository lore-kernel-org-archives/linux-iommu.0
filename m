From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 1/1] IOMMU: Save pci device id instead of pci_dev* pointer
 for DMAR devices
Date: Mon, 11 Nov 2013 08:55:04 +0800
Message-ID: <52802AE8.6070803@huawei.com>
References: <1383639898-48776-1-git-send-email-wangyijing@huawei.com> <1383639898-48776-2-git-send-email-wangyijing@huawei.com> <20131107180713.GA2955@google.com> <527C5D36.7050206@huawei.com> <CAErSpo73N2Th-4D5G8-60tMuGwqthfu-VNHVf3LF9+s2mQp53w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo73N2Th-4D5G8-60tMuGwqthfu-VNHVf3LF9+s2mQp53w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org

>> Hmmm, this is the thing I am most worried about. If we just only use
>> (pci_dev *) poninter in drhd->devices array as a identification. Change
>> (pci_dev *) pointer instead of pci device id segment:bus:devfn is safe.
>> Or, this is a wrong way to fix this issue. I don't know IOMMU driver much now,
>> so IOMMU guys any comments on this issue is welcome.
>>
>> If this is not safe, what about we both save pci device id and (pci_dev *) pointer
>> in drhd. So we can put pci_dev ref and set pci_dev * = NULL during device removed by bus notify, and
>> update (pci_dev *)pointer during device add.
> 
> I don't know the IOMMU drivers well either, but it seems like they
> rely on notifications of device addition and removal (see
> iommu_bus_notifier()).  It doesn't seem right for them to also use the
> generic PCI interfaces like pci_get_domain_bus_and_slot() because the
> IOMMU driver should already know what devices exist and their
> lifetimes.  It seems like confusion to mix the two.  But I don't have
> a concrete suggestion.

Maybe you are right~, I will try to rework the patch and resend soon.

Thanks!
Yijing.


> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> .
> 


-- 
Thanks!
Yijing
