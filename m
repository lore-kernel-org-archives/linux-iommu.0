From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 0/3] IOMMU: Tegra SMMU fixes
Date: Wed, 3 Apr 2019 08:14:18 +0300
Message-ID: <99d4f594-f9a0-1cf6-8031-a3faa8e091e3@gmail.com>
References: <20190306225009.3391-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306225009.3391-1-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

07.03.2019 1:50, Dmitry Osipenko пишет:
> Hello,
> 
> This small series primarily fixes a bug that affects Terga30 and
> Terga114 platforms, it also carries two patches that improve SMMU
> functionality and clean up code a tad.
> 
> Dmitry Osipenko (3):
>   iommu/tegra-smmu: Fix invalid ASID bits on Tegra30/114
>   iommu/tegra-smmu: Properly release domain resources
>   iommu/tegra-smmu: Respect IOMMU API read-write protections
> 
>  drivers/iommu/tegra-smmu.c | 41 ++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 

Joerg, could you please apply this series?
