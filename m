Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4806CC433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 10:56:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AED208A9
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 10:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iq0h45Xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AED208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EC22E86980;
	Wed, 26 Aug 2020 10:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r-Fnpwkj6Pv5; Wed, 26 Aug 2020 10:56:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 48F3C85625;
	Wed, 26 Aug 2020 10:56:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39FE7C016F;
	Wed, 26 Aug 2020 10:56:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66902C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 10:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 53FA186ACB
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 10:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6nAkp4EwpSF0 for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 10:56:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 624C5867A8
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 10:56:29 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QAtwMF014853;
 Wed, 26 Aug 2020 10:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=g9Ql9sKmcEYsuER3aA9MoOtpclK3oCvPADM1Sl0EZ5c=;
 b=Iq0h45XcrSMxESEl7mL2pDKFSW0njbDi5OKqiJ4QxJJ7k10ArJ6sXk78xGlHa7PmoXQ5
 xYdXfgNt9CxD22NWdXzL8OZWhbAbNqXeQ9KpYlh1F55R+rkFORtnK6xg+gO62z7FgbPN
 6UYZCJ//KSjErhar1IyBXqZHevGmt2vGPstqVxklgBckf2giF2yTmASsmiA1JXbg25DN
 eNZJAO5Nt7HUUy3SbqXcDNSDLsgb9CPdqwhZaD9Gx7+rwgd/Kt8u8pb92O7dkhdMv/8y
 +XQ18jTzGicGLSDj2Ijh2HHN6kTCUjkX2+ZmJ4cQSYcjOh/3siDMZvT5+sFX6c5v/xVH ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 333dbrypaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Aug 2020 10:56:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QAjOuS038492;
 Wed, 26 Aug 2020 10:54:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 333r9kr8t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2020 10:54:18 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07QAsERw008522;
 Wed, 26 Aug 2020 10:54:14 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Aug 2020 03:54:13 -0700
Date: Wed, 26 Aug 2020 13:54:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: FelixCuioc <FelixCui-oc@zhaoxin.com>
Subject: Re: [PATCH 1/3] iommu/vt-d:Add support for detecting ACPI device in
 RMRR
Message-ID: <20200826105404.GZ5493@kadam>
References: <20200826102752.3776-1-FelixCui-oc@zhaoxin.com>
 <20200826102752.3776-2-FelixCui-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200826102752.3776-2-FelixCui-oc@zhaoxin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1011
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

On Wed, Aug 26, 2020 at 06:27:50AM -0400, FelixCuioc wrote:
> Some ACPI devices need to issue dma requests to access
> the reserved memory area.BIOS uses the device scope type
> ACPI_NAMESPACE_DEVICE in RMRR to report these ACPI devices.
> This patch add support for detecting ACPI devices in RMRR.
> 
> Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
> ---
>  drivers/iommu/intel/dmar.c  | 74 ++++++++++++++++++++-----------------
>  drivers/iommu/intel/iommu.c | 22 ++++++++++-
>  include/linux/dmar.h        | 12 +++++-
>  3 files changed, 72 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 93e6345f3414..024ca38dba12 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -215,7 +215,7 @@ static bool dmar_match_pci_path(struct dmar_pci_notify_info *info, int bus,
>  }
>  
>  /* Return: > 0 if match found, 0 if no match found, < 0 if error happens */
> -int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
> +int dmar_pci_insert_dev_scope(struct dmar_pci_notify_info *info,
>  			  void *start, void*end, u16 segment,
>  			  struct dmar_dev_scope *devices,
>  			  int devices_cnt)
> @@ -304,7 +304,7 @@ static int dmar_pci_bus_add_dev(struct dmar_pci_notify_info *info)
>  
>  		drhd = container_of(dmaru->hdr,
>  				    struct acpi_dmar_hardware_unit, header);
> -		ret = dmar_insert_dev_scope(info, (void *)(drhd + 1),
> +		ret = dmar_pci_insert_dev_scope(info, (void *)(drhd + 1),
>  				((void *)drhd) + drhd->header.length,
>  				dmaru->segment,
>  				dmaru->devices, dmaru->devices_cnt);
> @@ -696,48 +696,56 @@ dmar_find_matched_drhd_unit(struct pci_dev *dev)
>  
>  	return dmaru;
>  }
> -
> -static void __init dmar_acpi_insert_dev_scope(u8 device_number,
> -					      struct acpi_device *adev)
> +int dmar_acpi_insert_dev_scope(u8 device_number,

The patch deleted the blank line between functions.  Make this function
bool, change the 1/0 to true/false.  Add a comment explaining what the
return values mean.

> +				struct acpi_device *adev,
> +				void *start, void *end,
> +				struct dmar_dev_scope *devices,
> +				int devices_cnt)
>  {
> -	struct dmar_drhd_unit *dmaru;
> -	struct acpi_dmar_hardware_unit *drhd;
>  	struct acpi_dmar_device_scope *scope;
>  	struct device *tmp;
>  	int i;
>  	struct acpi_dmar_pci_path *path;
>  
> +	for (; start < end; start += scope->length) {
> +		scope = start;

Are we sure that there is enough space for sizeof(*scope) in end - start?
(I don't know this code so maybe we are).

> +		if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
> +			continue;
> +		if (scope->enumeration_id != device_number)
> +			continue;
> +		path = (void *)(scope + 1);
> +		for_each_dev_scope(devices, devices_cnt, i, tmp)
> +			if (tmp == NULL) {
> +				devices[i].bus = scope->bus;
> +				devices[i].devfn = PCI_DEVFN(path->device, path->function);
> +				rcu_assign_pointer(devices[i].dev,
> +						   get_device(&adev->dev));
> +				return 1;
> +			}
> +		WARN_ON(i >= devices_cnt);
> +	}
> +	return 0;
> +}
> +static int dmar_acpi_bus_add_dev(u8 device_number, struct acpi_device *adev)
> +{
> +	struct dmar_drhd_unit *dmaru;
> +	struct acpi_dmar_hardware_unit *drhd;
> +	int ret = 0;

This initialization is never used.

> +
>  	for_each_drhd_unit(dmaru) {
>  		drhd = container_of(dmaru->hdr,
>  				    struct acpi_dmar_hardware_unit,
>  				    header);
> +		ret = dmar_acpi_insert_dev_scope(device_number, adev, (void *)(drhd+1),
> +						((void *)drhd)+drhd->header.length,
> +						dmaru->devices, dmaru->devices_cnt);
> +		if (ret)
> +			break;
> +	}
> +	ret = dmar_rmrr_add_acpi_dev(device_number, adev);

What about if dmar_acpi_insert_dev_scope() always returns zero, do we
still want to call dmar_rmrr_add_acpi_dev()?

>  
> -		for (scope = (void *)(drhd + 1);
> -		     (unsigned long)scope < ((unsigned long)drhd) + drhd->header.length;
> -		     scope = ((void *)scope) + scope->length) {
> -			if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
> -				continue;
> -			if (scope->enumeration_id != device_number)
> -				continue;
> +	return ret;
>  
> -			path = (void *)(scope + 1);
> -			pr_info("ACPI device \"%s\" under DMAR at %llx as %02x:%02x.%d\n",
> -				dev_name(&adev->dev), dmaru->reg_base_addr,
> -				scope->bus, path->device, path->function);
> -			for_each_dev_scope(dmaru->devices, dmaru->devices_cnt, i, tmp)
> -				if (tmp == NULL) {
> -					dmaru->devices[i].bus = scope->bus;
> -					dmaru->devices[i].devfn = PCI_DEVFN(path->device,
> -									    path->function);
> -					rcu_assign_pointer(dmaru->devices[i].dev,
> -							   get_device(&adev->dev));
> -					return;
> -				}
> -			BUG_ON(i >= dmaru->devices_cnt);
> -		}
> -	}
> -	pr_warn("No IOMMU scope found for ANDD enumeration ID %d (%s)\n",
> -		device_number, dev_name(&adev->dev));
>  }
>  
>  static int __init dmar_acpi_dev_scope_init(void)
> @@ -766,7 +774,7 @@ static int __init dmar_acpi_dev_scope_init(void)
>  				       andd->device_name);
>  				continue;
>  			}
> -			dmar_acpi_insert_dev_scope(andd->device_number, adev);
> +			dmar_acpi_bus_add_dev(andd->device_number, adev);
>  		}
>  	}
>  	return 0;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ca557d351518..f774ef63d473 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4507,6 +4507,24 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
>  
>  	return ret;
>  }
> +int dmar_rmrr_add_acpi_dev(u8 device_number, struct acpi_device *adev)

Please add a blank line between functions.
> +{
> +	int ret;
> +	struct dmar_rmrr_unit *rmrru;
> +	struct acpi_dmar_reserved_memory *rmrr;
> +
> +	list_for_each_entry(rmrru, &dmar_rmrr_units, list) {
> +		rmrr = container_of(rmrru->hdr,
> +				struct acpi_dmar_reserved_memory,
> +				header);
> +		ret = dmar_acpi_insert_dev_scope(device_number, adev, (void *)(rmrr + 1),
> +						((void *)rmrr) + rmrr->header.length,
> +						rmrru->devices, rmrru->devices_cnt);
> +		if (ret)
> +			break;
> +	}
> +	return 0;
> +}

regards,
dan carpenter

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
