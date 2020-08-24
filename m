Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB550C433DF
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 10:38:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F86B2067C
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 10:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wpOUpnbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F86B2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 35BF4879B1;
	Mon, 24 Aug 2020 10:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nYTA366QFvP6; Mon, 24 Aug 2020 10:38:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 43663878A6;
	Mon, 24 Aug 2020 10:38:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BB34C016F;
	Mon, 24 Aug 2020 10:38:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADACEC0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 10:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9447A8516A
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 10:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HNoI4FLlepBw for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 10:38:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 89C6585102
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 10:38:29 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OAYSdf122972;
 Mon, 24 Aug 2020 10:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=4GwqwGxOsdSn3tHT6bo9+w+ESsyiy6ym3exgxLC1b6o=;
 b=wpOUpnbAYKVSFSwpBZBMdFFJWgusicy7efZ5D5FtaJ7uP5xKFiN7Cj2tGehGpwvYoHlh
 jmPuZQ333lR26nDY94UiGaKONJOrqV2TZ1EB3+ABxLUSXKPiLs7GXxjCh30ugAFI5iVw
 rE/WbO1ZC0Q1To6dhsHJwh+LzIvDl7uxaAQfvG2xYuIsIwR0/EspAzHMpY4n1s3ViTgU
 bz/JCqBZ9eEmS/vP35ziWaxuX067+3wOgw45SocPESIZ/nBcF1c/cfpgQwG9DzcySEP4
 OUkUEbEVCPmJKBiSzsNFilEmBmZOxJKtH9cPl4zuH9h0Z2wH9UGLrdGMIvpgz6NiD0uB fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 333cshuu16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 24 Aug 2020 10:38:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OAVEEX091858;
 Mon, 24 Aug 2020 10:38:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 333r9h0rub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2020 10:38:17 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07OAc6dV013405;
 Mon, 24 Aug 2020 10:38:06 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Aug 2020 03:38:04 -0700
Date: Mon, 24 Aug 2020 13:37:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@lists.01.org, FelixCuioc <FelixCui-oc@zhaoxin.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d:Add support for probing ACPI device in RMRR
Message-ID: <20200824103756.GA1793@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hNG1vEeyG8BCaHbQ"
Content-Disposition: inline
In-Reply-To: <20200818024623.2406-1-FelixCui-oc@zhaoxin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240083
Cc: kbuild-all@lists.01.org, lkp@intel.com, CobeChen-oc@zhaoxin.com
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


--hNG1vEeyG8BCaHbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi FelixCuioc,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/FelixCuioc/iommu-vt-d-Add-support-for-probing-ACPI-device-in-RMRR/20200818-104920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-randconfig-m001-20200820 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/iommu/intel/iommu.c:4850 probe_acpi_namespace_devices() warn: inconsistent returns 'adev->physical_node_lock'.

Old smatch warnings:
drivers/iommu/intel/iommu.c:836 device_to_iommu() error: we previously assumed 'pdev' could be null (see line 809)
drivers/iommu/intel/iommu.c:2272 __domain_mapping() error: we previously assumed 'sg' could be null (see line 2263)
drivers/iommu/intel/iommu.c:4371 intel_iommu_add() warn: should '(1 << sp)' be a 64 bit type?

# https://github.com/0day-ci/linux/commit/3adfd53a32c52833a34033fabaa5c1e65dfca688
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review FelixCuioc/iommu-vt-d-Add-support-for-probing-ACPI-device-in-RMRR/20200818-104920
git checkout 3adfd53a32c52833a34033fabaa5c1e65dfca688
vim +4850 drivers/iommu/intel/iommu.c

fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4797  static int __init probe_acpi_namespace_devices(void)
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4798  {
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4799  	struct dmar_drhd_unit *drhd;
af88ec3962010e3 drivers/iommu/intel-iommu.c Qian Cai   2019-06-03  4800  	/* To avoid a -Wunused-but-set-variable warning. */
af88ec3962010e3 drivers/iommu/intel-iommu.c Qian Cai   2019-06-03  4801  	struct intel_iommu *iommu __maybe_unused;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4802  	struct device *dev;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4803  	int i, ret = 0;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4804  
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4805  	for_each_active_iommu(iommu, drhd) {
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4806  		for_each_active_dev_scope(drhd->devices,
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4807  					  drhd->devices_cnt, i, dev) {
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4808  			struct acpi_device_physical_node *pn;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4809  			struct iommu_group *group;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4810  			struct acpi_device *adev;
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4811  			struct device *pn_dev = NULL;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4812  
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4813  			if (dev->bus != &acpi_bus_type)
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4814  				continue;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4815  
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4816  			adev = to_acpi_device(dev);
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4817  			mutex_lock(&adev->physical_node_lock);
                                                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4818  			list_for_each_entry(pn,
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4819  					    &adev->physical_node_list, node) {
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4820  				group = iommu_group_get(pn->dev);
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4821  				if (group) {
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4822  					pn_dev = pn->dev;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4823  					iommu_group_put(group);
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4824  					continue;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4825  				}
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4826  
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4827  				pn->dev->bus->iommu_ops = &intel_iommu_ops;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4828  				ret = iommu_probe_device(pn->dev);
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4829  				if (ret)
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4830  					break;
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4831  				pn_dev = pn->dev;
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4832  			}
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4833  			if (pn_dev == NULL) {
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4834  				dev->bus->iommu_ops = &intel_iommu_ops;
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4835  				ret = iommu_probe_device(dev);
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4836  				if (ret) {
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4837  					pr_err("acpi_device probe fail! ret:%d\n", ret);
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4838  					return ret;

Need to unlock.

3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4839  				}
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4840  				return 0;

Here too.

fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4841  			}
3adfd53a32c5283 drivers/iommu/intel/iommu.c FelixCuioc 2020-08-17  4842  			ret = acpi_device_create_direct_mappings(pn_dev, dev);
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4843  			mutex_unlock(&adev->physical_node_lock);
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4844  
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4845  			if (ret)
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4846  				return ret;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4847  		}
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4848  	}
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4849  
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25 @4850  	return 0;
fa212a97f3a366a drivers/iommu/intel-iommu.c Lu Baolu   2019-05-25  4851  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--hNG1vEeyG8BCaHbQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--hNG1vEeyG8BCaHbQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--hNG1vEeyG8BCaHbQ--
