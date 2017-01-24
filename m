From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
 deferred probing or error
Date: Tue, 24 Jan 2017 21:14:19 +0800
Message-ID: <5887532B.3070506@linaro.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org> <1485188293-20263-9-git-send-email-sricharan@codeaurora.org> <20170124123711.GA11996@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170124123711.GA11996@red-moon>
Sender: linux-pci-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sricharan R <sricharan@codeaurora.org>
Cc: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>, Sinan Kaya <okaya@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo, Sricharan,

On 01/24/2017 08:37 PM, Lorenzo Pieralisi wrote:
> [+hanjun, tomasz, sinan]
>
> It is quite a key patchset, I would be glad if they can test on their
> respective platforms with IORT.

ACPI patches are conflict with my acpi platform msi patches (I need
them to enable devices on my ARM64 platform then test this patch set),
I will fix the conflict and test it tomorrow (out of office now and
can't reach the test machines) :)

Thanks
Hanjun
