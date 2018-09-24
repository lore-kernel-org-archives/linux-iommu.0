From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 18/20] iommu/tegra: gart: Don't detach devices from
 inactive domains
Date: Mon, 24 Sep 2018 21:05:48 +0300
Message-ID: <8be80297-3b13-ece6-a5bf-873cc7877989@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-19-digetx@gmail.com> <20180924110047.GO21032@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924110047.GO21032@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 9/24/18 2:00 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:51AM +0300, Dmitry Osipenko wrote:
>> There could be unlimited number of allocated domains, but only one domain
>> can be active at a time. Hence devices must be detached only from the
>> active domain.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-gart.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Do we have a mechanism of switching out different domains? I don't think
> we do, so I'm wondering if perhaps a better solution to this would be to
> just refuse to create more than one domain in the first place. That
> would also allow us to get rid of the global variable gart_handle.

That's what was done in v1, Robin Murphy suggested that it will be
better not to restrict allocation of unpopulated domains. It is
mentioned in the changelog, see comment to v2 changes.
