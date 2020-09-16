Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA092C2BB84
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 17:10:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B787221F1
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 17:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FlumdxNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B787221F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 91A29228EC;
	Wed, 16 Sep 2020 17:10:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FujE1E0DX2qd; Wed, 16 Sep 2020 17:10:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 11C202034C;
	Wed, 16 Sep 2020 17:10:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC981C0888;
	Wed, 16 Sep 2020 17:10:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E1DFC0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 17:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1DBD486A79
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 17:10:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UoOUOYaE0WIH for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 17:10:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7E705869EF
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 17:10:24 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GH4ADB183693;
 Wed, 16 Sep 2020 17:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9bln1IG5mw+Sl51BcjQd98EtjhJKHV8PeNOGu2Eppew=;
 b=FlumdxNcjyxRf16TOvLGo9LzR9RZETJ7NOoP9l2Q5w2kHxcQw/Ai9OUQIhbd9+gxYo5x
 HMjCA2/mr9IBXAE3phlYjdZGEhmF0Jdvr4hv6B+IxYLhcnpIABuvvAktBUJelSUL0vMZ
 V+9b3B81qv6d5d4L4sN6v1sflHsg82My2UV2jS5p/mHthRPNxLt7PbXs0osZb266iwgO
 3oJxmIZcIXi+Myvxn2QZzNTQg364jIOjmsNaj5Ykt0EvezaC6TBNNlnoqGqTmyR9Hlkn
 TKNKcWxx6bOinJCQf7KsopDApR+mPprkVWlKnJ1l5dRngPvtAmkqpJ7a3FwacsgXG1Gt Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 33gnrr4ec2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Sep 2020 17:10:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GH616O141707;
 Wed, 16 Sep 2020 17:10:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 33khpkrh6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2020 17:10:15 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08GHADqK029739;
 Wed, 16 Sep 2020 17:10:13 GMT
Received: from [10.175.184.173] (/10.175.184.173)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 16 Sep 2020 17:10:13 +0000
Subject: Re: [PATCH v2] iommu/amd: Restore IRTE.RemapEn bit for
 amd_iommu_activate_guest_mode
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20200916111720.43913-1-suravee.suthikulpanit@amd.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <3dd694a9-ad1e-f9ed-ac9b-20052f985f38@oracle.com>
Date: Wed, 16 Sep 2020 18:10:08 +0100
MIME-Version: 1.0
In-Reply-To: <20200916111720.43913-1-suravee.suthikulpanit@amd.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=1
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=1
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160120
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mlevitsk@redhat.com
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

On 9/16/20 12:17 PM, Suravee Suthikulpanit wrote:
> Commit e52d58d54a32 ("iommu/amd: Use cmpxchg_double() when updating
> 128-bit IRTE") removed an assumption that modify_irte_ga always set
> the valid bit, which requires the callers to set the appropriate value
> for the struct irte_ga.valid bit before calling the function.
> 
> Similar to the commit 26e495f34107 ("iommu/amd: Restore IRTE.RemapEn
> bit after programming IRTE"), which is for the function
> amd_iommu_deactivate_guest_mode().
> 
> The same change is also needed for the amd_iommu_activate_guest_mode().
> Otherwise, this could trigger IO_PAGE_FAULT for the VFIO based VMs with
> AVIC enabled.
> 
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Tested-by: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Fixes: e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index e938677af8bc..db4fb840c59c 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3900,14 +3900,18 @@ int amd_iommu_activate_guest_mode(void *data)
>  {
>  	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>  	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
> +	u64 valid;
>  
>  	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>  	    !entry || entry->lo.fields_vapic.guest_mode)
>  		return 0;
>  
> +	valid = entry->lo.fields_vapic.valid;
> +
>  	entry->lo.val = 0;
>  	entry->hi.val = 0;
>  
> +	entry->lo.fields_vapic.valid       = valid;
>  	entry->lo.fields_vapic.guest_mode  = 1;
>  	entry->lo.fields_vapic.ga_log_intr = 1;
>  	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
> 
FWIW,

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
