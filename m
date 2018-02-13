From: "Hook, Gary" <ghook@amd.com>
Subject: Re: [PATCH] iommu/amd - Use dev_err to send events to the system log
Date: Tue, 13 Feb 2018 14:24:56 -0500
Message-ID: <f7e7e2c2-c83d-9c4a-f3ac-5c351576b567@amd.com>
References: <151736066756.21649.4739957712713863861.stgit@sosam4>
 <20180213132216.gyhndywyu23cdzbv@8bytes.org>
 <325d7406-e01b-f7a1-3da6-390b0cf9bc94@amd.com>
 <20180213160018.fg7baclgu5o5rgxc@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180213160018.fg7baclgu5o5rgxc@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 2/13/2018 11:00 AM, Joerg Roedel wrote:
> On Tue, Feb 13, 2018 at 10:47:55AM -0500, Hook, Gary wrote:
>>
>>          dev_err(&iommu->dev->dev, "ILLEGAL...
> 
> I think its more something like iommu->iommu->dev.
> 
> 


Without actually running a driver and getting some debug info, I'll just
say that my example compiled, the amd_iommu structure points to a 
pci_dev which contains a device, and the two possibilities are likely 
equivalent.

I'll vet that, of course, but working under the assumption that they are 
equivalent, the question becomes, do you have a preference?

Thanks,
Gary
