Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F827B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 08:49:51 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([114.249.61.130])
	by sina.com (172.16.97.35) with ESMTP
	id 63EDEE07000195A4; Thu, 16 Feb 2023 16:49:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 22624815073511
From: Hillf Danton <hdanton@sina.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Li Bin <huawei.libin@huawei.com>,
	Xie XiuQi <xiexiuqi@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH] iommu: Avoid softlockup and rcu stall in fq_flush_timeout().
Date: Thu, 16 Feb 2023 16:49:02 +0800
Message-Id: <20230216084902.1486-1-hdanton@sina.com>
In-Reply-To: <20230216071148.2060-1-zhangpeng.00@bytedance.com>
References: 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 Feb 2023 15:11:48 +0800 Peng Zhang <zhangpeng.00@bytedance.com>
> There is softlockup under fio pressure test with smmu enabled:
> watchdog: BUG: soft lockup - CPU#81 stuck for 22s!  [swapper/81:0]

What is your kernel version?

> This is because the timer callback fq_flush_timeout may run more than
> 10ms, and timer may be processed continuously in the softirq so trigger
> softlockup and rcu stall. We can use work to deal with fq_ring_free for
> each cpu which may take long time, that to avoid triggering softlockup
> and rcu stall.
> 
> This patch is modified from the patch[1] of openEuler.

Because of a timer hog observed on your system with 128 CPUs for instance
does it make any sense to ask Peter to apply the patch for his 2-CPU box?
