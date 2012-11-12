From: Hiroshi Doyu <hdoyu@nvidia.com>
Subject: Re: [PATCH 2/3] iommu/tegra-smmu.c: fix dentry reference leak in
 smmu_debugfs_stats_show().
Date: Mon, 12 Nov 2012 08:39:35 +0100
Message-ID: <20121112.093935.1354253140075405263.hdoyu@nvidia.com>
References: <1352666971-13551-1-git-send-email-tipecaml@gmail.com><1352666971-13551-3-git-send-email-tipecaml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352666971-13551-3-git-send-email-tipecaml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "tipecaml@gmail.com" <tipecaml@gmail.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "joro@8bytes.org" <joro@8bytes.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

Cyril Roelandt <tipecaml@gmail.com> wrote @ Sun, 11 Nov 2012 21:49:30 +0100:

> Call to d_find_alias() needs a corresponding dput().
> 
> Signed-off-by: Cyril Roelandt <tipecaml@gmail.com>
> ---

Thanks. Looks ok for me. Acked-by Hiroshi Doyu <hdoyu@nvidia.com>
