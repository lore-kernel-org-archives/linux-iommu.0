Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FA7C433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 11:00:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873462075E
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 11:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C75aLRqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873462075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B6E38791E;
	Wed, 26 Aug 2020 11:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7zV61+1dOr1; Wed, 26 Aug 2020 11:00:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 373A8876F4;
	Wed, 26 Aug 2020 11:00:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E884C016F;
	Wed, 26 Aug 2020 11:00:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C563FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C190786B2D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JsYIKrakxj6M for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 11:00:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BA16C86B2B
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:00:29 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QAuVY1015194;
 Wed, 26 Aug 2020 10:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7Zw+V3BeHtC6SbyuG2LYpNjTSDAtiw84SRplymVth08=;
 b=C75aLRqmGXFoNhsBYqhBE5I6j7qUe5SWO9m/BXlAqYMAgrYM0T9Tsu48we96DWAHiz7/
 3ATl4WN5j4yXJVPlt79nIV/B3WL2U8FEoHykiejoFPROWzMThRimlb78qQNLuX3rZ9F7
 xP1cW5FeOaQTYybr0TH8hq9gLAM+bHbNQFmpfwlai1SkeeCBNLvGSeHp9kjAaRtF1TTz
 N6r4sjptlQ0l8t3h2PAKx9iOcTJ79IFtHlfh2vCqbqL+7FbPChRMeQqgJjXWPwQr48vT
 PXfMdxtcCS1tbb45+DW+qQ9A5sfTHMEZ4PMbqV6rEd4Vtlbcm9l4OlKO0ikpn6qAc7/7 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 333dbrypjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Aug 2020 10:58:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QAudk2012355;
 Wed, 26 Aug 2020 10:58:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 333rtyyns2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2020 10:58:57 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07QAwub2027777;
 Wed, 26 Aug 2020 10:58:56 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Aug 2020 03:58:55 -0700
Date: Wed, 26 Aug 2020 13:58:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: FelixCuioc <FelixCui-oc@zhaoxin.com>
Subject: Re: [PATCH 2/3] iommu/vt-d:Add support for probing ACPI device in RMRR
Message-ID: <20200826105847.GA5493@kadam>
References: <20200826102752.3776-1-FelixCui-oc@zhaoxin.com>
 <20200826102752.3776-3-FelixCui-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200826102752.3776-3-FelixCui-oc@zhaoxin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260088
Cc: kbuild-all@lists.01.org, CobeChen-oc@zhaoxin.com, kbuild@lists.01.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 TonyWWang-oc@zhaoxin.com, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Aug 26, 2020 at 06:27:51AM -0400, FelixCuioc wrote:
> After acpi device in RMRR is detected,it is necessary
> to establish a mapping for these devices.
> In acpi_device_create_direct_mappings(),create a mapping
> for the acpi device in RMRR.
> Add a helper to achieve the acpi namespace device can
> access the RMRR region.
> 
> Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
> ---
>  drivers/iommu/intel/iommu.c | 27 +++++++++++++++++++++++++++
>  drivers/iommu/iommu.c       |  6 ++++++
>  include/linux/iommu.h       |  3 +++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index f774ef63d473..b31f02f41c96 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4797,6 +4797,20 @@ static int __init platform_optin_force_iommu(void)
>  
>  	return 1;
>  }
> +static int acpi_device_create_direct_mappings(struct device *pn_dev, struct device *acpi_device)

Blank line.

> +{
> +	struct iommu_group *group;
> +
> +	acpi_device->bus->iommu_ops = &intel_iommu_ops;
> +	group = iommu_group_get(pn_dev);
> +	if (!group) {
> +		pr_warn("ACPI name space devices create direct mappings wrong!\n");
> +		return -1;

Use a proper error code.  -ENOMEM?  -EINVAL?

> +	}
> +	__acpi_device_create_direct_mappings(group, acpi_device);
> +
> +	return 0;
> +}
>  
>  static int __init probe_acpi_namespace_devices(void)
>  {
> @@ -4812,6 +4826,7 @@ static int __init probe_acpi_namespace_devices(void)
>  			struct acpi_device_physical_node *pn;
>  			struct iommu_group *group;
>  			struct acpi_device *adev;
> +			struct device *pn_dev = NULL;
>  
>  			if (dev->bus != &acpi_bus_type)
>  				continue;
> @@ -4822,6 +4837,7 @@ static int __init probe_acpi_namespace_devices(void)
>  					    &adev->physical_node_list, node) {
>  				group = iommu_group_get(pn->dev);
>  				if (group) {
> +					pn_dev = pn->dev;
>  					iommu_group_put(group);
>  					continue;
>  				}
> @@ -4830,7 +4846,18 @@ static int __init probe_acpi_namespace_devices(void)
>  				ret = iommu_probe_device(pn->dev);
>  				if (ret)
>  					break;
> +				pn_dev = pn->dev;
> +			}
> +			if (pn_dev == NULL) {

Run checkpatch.pl --strict on this patch.  Use "if (!pn_dev) {".

> +				dev->bus->iommu_ops = &intel_iommu_ops;
> +				ret = iommu_probe_device(dev);
> +				if (ret) {
> +					pr_err("acpi_device probe fail! ret:%d\n", ret);
> +					return ret;
                                        ^^^^^^^^^^
This should be goto unlock;

> +				}
> +				return 0;
                                ^^^^^^^^
>  			}
> +			ret = acpi_device_create_direct_mappings(pn_dev, dev);

unlock:

>  			mutex_unlock(&adev->physical_node_lock);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
regards,
dan carpenter

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
