Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFE3C3B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 11:45:16 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([114.249.61.130])
	by sina.com (172.16.97.35) with ESMTP
	id 63EE172500021753; Thu, 16 Feb 2023 19:44:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 33284515074517
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
Date: Thu, 16 Feb 2023 19:44:28 +0800
Message-Id: <20230216114428.1622-1-hdanton@sina.com>
In-Reply-To: <65da1862-364b-9500-4be7-a463a12e6a7f@bytedance.com>
References: <20230216084902.1486-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 16 Feb 2023 19:02:59 +0800 Peng Zhang <zhangpeng.00@bytedance.com>
> 在 2023/2/16 16:49, Hillf Danton 写道:
> > On Thu, 16 Feb 2023 15:11:48 +0800 Peng Zhang <zhangpeng.00@bytedance.com>
> >> There is softlockup under fio pressure test with smmu enabled:
> >> watchdog: BUG: soft lockup - CPU#81 stuck for 22s!  [swapper/81:0]
> > 
> > What is your kernel version?
>
> Rcu stall occurs in kernel version 5.4.

Info like 5.4 and the number of CPUs helps understand your work.

> The test where the softlockup happened was not done by me, so I don't 
> know the kernel version.
> However, it is the same as the code logic of fq_flush_timeout in the 
> mainline kernel.

Could it be reproduced with mainline and a system with two CPUs?
