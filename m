From: "Hook, Gary" <ghook@amd.com>
Subject: Re: [PATCH] iommu/amd - Use dev_err to send events to the system log
Date: Tue, 13 Feb 2018 10:47:55 -0500
Message-ID: <325d7406-e01b-f7a1-3da6-390b0cf9bc94@amd.com>
References: <151736066756.21649.4739957712713863861.stgit@sosam4>
 <20180213132216.gyhndywyu23cdzbv@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180213132216.gyhndywyu23cdzbv@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 2/13/2018 8:22 AM, Joerg Roedel wrote:
> On Tue, Jan 30, 2018 at 07:04:27PM -0600, Gary R Hook wrote:
>> +		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
>> +			"address=0x%016llx flags=0x%04x]\n",
>> +			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>> +			address, flags);
> 
> That prints the PCI device-name of the IOMMU in front of the message. Is
> that actually helpful?
> 
> If at all, we should print the name of the iommu-device in front of the
> message, not the PCI device that hosts the IOMMU.

so (e.g.):

         dev_err(&iommu->dev->dev, "ILLEGAL...

?

I'm okay with that. It does make more sense.

Gary
