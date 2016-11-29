From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v9 09/16] drivers: acpi: iort: add support for ARM SMMU
 platform devices creation
Date: Tue, 29 Nov 2016 20:17:58 +0800
Message-ID: <11ea77fa-688f-d31d-bd3c-35ca52e0a18b@linaro.org>
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-10-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20161121100148.24769-10-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, iommu@lists.linux-foundation.org
Cc: Tomasz Nowicki <tn@semihalf.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>, Eric Auger <eric.auger@redhat.com>, Sinan Kaya <okaya@codeaurora.org>, Nate Watterson <nwatters@codeaurora.org>, Prem Mallappa <prem.mallappa@broadcom.com>, Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 2016/11/21 18:01, Lorenzo Pieralisi wrote:
> In ARM ACPI systems, IOMMU components are specified through static
> IORT table entries. In order to create platform devices for the
> corresponding ARM SMMU components, IORT kernel code should be made
> able to parse IORT table entries and create platform devices
> dynamically.
>
> This patch adds the generic IORT infrastructure required to create
> platform devices for ARM SMMUs.
>
> ARM SMMU versions have different resources requirement therefore this
> patch also introduces an IORT specific structure (ie iort_iommu_config)
> that contains hooks (to be defined when the corresponding ARM SMMU
> driver support is added to the kernel) to be used to define the
> platform devices names, init the IOMMUs, count their resources and
> finally initialize them.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/arm64/iort.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 151 insertions(+)

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
