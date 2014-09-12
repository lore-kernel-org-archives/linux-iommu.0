From: kiran.padwal@smartplayin.com
Subject: =?utf-8?Q?Re=3A_=5BPATCH=5D_iommu=3A_Make_of=5Fdevice=5Fid_array_const?=
Date: Fri, 12 Sep 2014 08:44:50 -0400 (EDT)
Message-ID: <1410525890.331211558@apps.rackspace.com>
References: <1410442656-21112-1-git-send-email-kiran.padwal@smartplayin.com>
 <20140911135119.GH6158@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140911135119.GH6158@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "hdoyu@nvidia.com" <hdoyu@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org



On Thursday, September 11, 2014 9:51am, "Will Deacon" <will.deacon@arm.com> said:

> On Thu, Sep 11, 2014 at 02:37:36PM +0100, Kiran Padwal wrote:
>> Make of_device_id array const, because all OF functions handle it as const.
>>
>> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
>> ---
>>  drivers/iommu/arm-smmu.c   |    2 +-
>>  drivers/iommu/omap-iommu.c |    2 +-
>>  drivers/iommu/tegra-gart.c |    2 +-
>>  drivers/iommu/tegra-smmu.c |    2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> Ha, I've seen a few of these patches recently. Did some tool just get
> support for detecting this?

No

> 
> Anyway, looks fine and should probably go via Joerg.
> 
> Will
> 
