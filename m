Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF65C433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 01:08:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D552053B
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 01:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D552053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A08E6221F5;
	Tue, 23 Jun 2020 01:07:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FT6K5ewnsCks; Tue, 23 Jun 2020 01:07:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9EFEE20415;
	Tue, 23 Jun 2020 01:07:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8267AC088F;
	Tue, 23 Jun 2020 01:07:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AB96C016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 01:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 440D2886B7
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 01:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7lcWaO3r5sYR for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 01:07:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0C75787ED1
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 01:07:52 +0000 (UTC)
IronPort-SDR: 0QztU+aIdRjlV0tNLN02RspCsR63fw+W9UJelI7Rvuoc3BgUxiX5xtgVklCitE0y/xm8p+4bSm
 YjjCd1qBCPeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="142187376"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
 d="gz'50?scan'50,208,50";a="142187376"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 18:07:42 -0700
IronPort-SDR: 2XigiH+g+2y20YuvKJHNIfpzEHzb5B4dTeMOXUzeZv+tY/I7eB4+Cicga1KG+2l8m3iPgiuR6R
 jtENsEpm9svA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
 d="gz'50?scan'50,208,50";a="301031270"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2020 18:07:39 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1jnXPW-0000X7-EU; Tue, 23 Jun 2020 01:07:38 +0000
Date: Tue, 23 Jun 2020 09:07:34 +0800
From: kernel test robot <lkp@intel.com>
To: John Garry <john.garry@huawei.com>, will@kernel.org, robin.murphy@arm.com
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
Message-ID: <202006230905.3HpPgtSC%lkp@intel.com>
References: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: trivial@kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org, kbuild-all@lists.01.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi John,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/John-Garry/iommu-arm-smmu-v3-Improve-cmdq-lock-efficiency/20200623-013438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm64-randconfig-c024-20200622 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

In file included from include/linux/bits.h:23,
from include/linux/ioport.h:15,
from include/linux/acpi.h:12,
from drivers/iommu/arm-smmu-v3.c:12:
drivers/iommu/arm-smmu-v3.c: In function 'arm_smmu_cmdq_issue_cmdlist':
include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
|                            ^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
|                                                              ^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
|   ^~~~~~~~~~~~~~~~~~~
>> drivers/iommu/arm-smmu-v3.c:1404:18: note: in expansion of macro 'GENMASK'
1404 |  u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);
|                  ^~~~~~~
include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
|                                        ^
include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
|                                                              ^
include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
|   ^~~~~~~~~~~~~~~~~~~
>> drivers/iommu/arm-smmu-v3.c:1404:18: note: in expansion of macro 'GENMASK'
1404 |  u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);
|                  ^~~~~~~

vim +/GENMASK +1404 drivers/iommu/arm-smmu-v3.c

  1369	
  1370	/*
  1371	 * This is the actual insertion function, and provides the following
  1372	 * ordering guarantees to callers:
  1373	 *
  1374	 * - There is a dma_wmb() before publishing any commands to the queue.
  1375	 *   This can be relied upon to order prior writes to data structures
  1376	 *   in memory (such as a CD or an STE) before the command.
  1377	 *
  1378	 * - On completion of a CMD_SYNC, there is a control dependency.
  1379	 *   This can be relied upon to order subsequent writes to memory (e.g.
  1380	 *   freeing an IOVA) after completion of the CMD_SYNC.
  1381	 *
  1382	 * - Command insertion is totally ordered, so if two CPUs each race to
  1383	 *   insert their own list of commands then all of the commands from one
  1384	 *   CPU will appear before any of the commands from the other CPU.
  1385	 *
  1386	 * - A CMD_SYNC is always inserted, which ensures we limit the prod pointer
  1387	 *   for when the cmdq is full, such that we don't wrap more than twice.
  1388	 *   It also makes it easy for the owner to know by how many to increment the
  1389	 *   cmdq lock.
  1390	 */
  1391	static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
  1392					       u64 *cmds, int n)
  1393	{
  1394		u64 cmd_sync[CMDQ_ENT_DWORDS];
  1395		const int sync = 1;
  1396		u32 prod;
  1397		unsigned long flags;
  1398		bool owner;
  1399		struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
  1400		struct arm_smmu_ll_queue llq = {
  1401			.max_n_shift = cmdq->q.llq.max_n_shift,
  1402		}, head = llq, space = llq;
  1403		u32 owner_val = 1 << cmdq->q.llq.owner_count_shift;
> 1404		u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);
  1405		u32 owner_mask = GENMASK(30, cmdq->q.llq.owner_count_shift);
  1406		int ret = 0;
  1407	
  1408		/* 1. Allocate some space in the queue */
  1409		local_irq_save(flags);
  1410	
  1411		prod = atomic_fetch_add(n + sync + owner_val,
  1412					&cmdq->q.llq.atomic.prod);
  1413	
  1414		owner = !(prod & owner_mask);
  1415		llq.prod = prod_mask & prod;
  1416		head.prod = queue_inc_prod_n(&llq, n + sync);
  1417	
  1418		/*
  1419		 * Ensure it's safe to write the entries. For this, we need to ensure
  1420		 * that there is space in the queue from our prod pointer.
  1421		 */
  1422		space.cons = READ_ONCE(cmdq->q.llq.cons);
  1423		space.prod = llq.prod;
  1424		while (!queue_has_space(&space, n + sync)) {
  1425			if (arm_smmu_cmdq_poll_until_not_full(smmu, &space))
  1426				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
  1427	
  1428			space.prod = llq.prod;
  1429		}
  1430	
  1431		/*
  1432		 * 2. Write our commands into the queue
  1433		 * Dependency ordering from the space-checking while loop, above.
  1434		 */
  1435		arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
  1436	
  1437		prod = queue_inc_prod_n(&llq, n);
  1438		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
  1439		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
  1440	
  1441		/* 3. Mark our slots as valid, ensuring commands are visible first */
  1442		dma_wmb();
  1443		arm_smmu_cmdq_set_valid_map(cmdq, llq.prod, head.prod);
  1444	
  1445		/* 4. If we are the owner, take control of the SMMU hardware */
  1446		if (owner) {
  1447			int owner_count;
  1448			u32 prod_tmp;
  1449	
  1450			/* a. Wait for previous owner to finish */
  1451			atomic_cond_read_relaxed(&cmdq->owner_prod, VAL == llq.prod);
  1452	
  1453			/* b. Stop gathering work by clearing the owned mask */
  1454			prod_tmp = atomic_fetch_andnot_relaxed(~prod_mask,
  1455							       &cmdq->q.llq.atomic.prod);
  1456			prod = prod_tmp & prod_mask;
  1457			owner_count = prod_tmp & owner_mask;
  1458			owner_count >>= cmdq->q.llq.owner_count_shift;
  1459	
  1460			/*
  1461			 * c. Wait for any gathered work to be written to the queue.
  1462			 * Note that we read our own entries so that we have the control
  1463			 * dependency required by (d).
  1464			 */
  1465			arm_smmu_cmdq_poll_valid_map(cmdq, llq.prod, prod);
  1466	
  1467			/*
  1468			 * In order to determine completion of the CMD_SYNCs, we must
  1469			 * ensure that the queue can't wrap twice without us noticing.
  1470			 * We achieve that by taking the cmdq lock as shared before
  1471			 * progressing the prod pointer.
  1472			 * The owner does this for all the non-owners it has gathered.
  1473			 * Otherwise, some non-owner(s) may lock the cmdq, blocking
  1474			 * cons being updating. This could be when the cmdq has just
  1475			 * become full. In this case, other sibling non-owners could be
  1476			 * blocked from progressing, leading to deadlock.
  1477			 */
  1478			arm_smmu_cmdq_shared_lock(cmdq, owner_count);
  1479	
  1480			/*
  1481			 * d. Advance the hardware prod pointer
  1482			 * Control dependency ordering from the entries becoming valid.
  1483			 */
  1484			writel_relaxed(prod, cmdq->q.prod_reg);
  1485	
  1486			/*
  1487			 * e. Tell the next owner we're done
  1488			 * Make sure we've updated the hardware first, so that we don't
  1489			 * race to update prod and potentially move it backwards.
  1490			 */
  1491			atomic_set_release(&cmdq->owner_prod, prod);
  1492		}
  1493	
  1494		/* 5. Since we always insert a CMD_SYNC, we must wait for it to complete */
  1495		llq.prod = queue_inc_prod_n(&llq, n);
  1496		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
  1497		if (ret)
  1498			dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
  1499					    llq.prod, readl_relaxed(cmdq->q.prod_reg),
  1500					    readl_relaxed(cmdq->q.cons_reg));
  1501	
  1502		/*
  1503		 * Try to unlock the cmdq lock. This will fail if we're the last reader,
  1504		 * in which case we can safely update cmdq->q.llq.cons
  1505		 */
  1506		if (!arm_smmu_cmdq_shared_tryunlock(cmdq)) {
  1507			WRITE_ONCE(cmdq->q.llq.cons, llq.cons);
  1508			arm_smmu_cmdq_shared_unlock(cmdq);
  1509		}
  1510	
  1511		local_irq_restore(flags);
  1512		return ret;
  1513	}
  1514	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--9jxsPFA5p3P2qPhR
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
+rr2/wDcO6rdp+gBAA==

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--9jxsPFA5p3P2qPhR--
