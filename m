From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v9 08/16] drivers: acpi: iort: add node match function
Date: Tue, 29 Nov 2016 20:14:41 +0800
Message-ID: <07ed6a31-c791-8832-530c-42ac58806848@linaro.org>
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-9-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20161121100148.24769-9-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, iommu@lists.linux-foundation.org
Cc: Tomasz Nowicki <tn@semihalf.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>, Eric Auger <eric.auger@redhat.com>, Sinan Kaya <okaya@codeaurora.org>, Nate Watterson <nwatters@codeaurora.org>, Prem Mallappa <prem.mallappa@broadcom.com>, Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 2016/11/21 18:01, Lorenzo Pieralisi wrote:
> Device drivers (eg ARM SMMU) need to know if a specific component
> is part of the IORT table, so that kernel data structures are not
> initialized at initcalls time if the respective component is not
> part of the IORT table.
>
> To this end, this patch adds a trivial function that allows detecting
> if a given IORT node type is present or not in the ACPI table, providing
> an ACPI IORT equivalent for of_find_matching_node().
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
