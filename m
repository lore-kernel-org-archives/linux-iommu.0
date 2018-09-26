From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V3] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
Date: Wed, 26 Sep 2018 13:20:56 -0400
Message-ID: <e2da631e-ccbf-af94-ea0c-6c6c4d842768@codeaurora.org>
References: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
 <20180926162235.GA30177@araj-mobl1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926162235.GA30177@araj-mobl1.jf.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Raj, Ashok" <ashok.raj@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, open list <linux-kernel@vger.kernel.org>, Ashok Raj <ashok.raj@intel.com>, IOMMU Mailing List <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On 9/26/2018 12:22 PM, Raj, Ashok wrote:
>> pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
>> +	if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
>> +		return;
> Forgot to notice this.. I'm not sure if the same enforcement is
> required for devices that are RCIEP. The spec isn't clear about calling
> any excemption. Although it should be simple for devices to expose
> e2etlp support, but if they don't that should be ok, since there are
> nothing between itself and the root port.
> 
> We are seeking help from our SIG reps, but thought I'll ask here as well
> if there are other opinions.
> 

This patch actually broke the integrated endpoints like you were mentioning.
It was fixed by a follow up patch from nvidia guys.

https://github.com/torvalds/linux/commit/9d27e39d309c93025ae6aa97236af15bef2a5f1f#diff-a7f0acd715e991df5dfb450d2b9abebc
