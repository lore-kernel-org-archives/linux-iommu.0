Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D996CC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 03:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 64265400E7;
	Wed, 22 Jun 2022 03:22:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64265400E7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eVFOr5i3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UmuBpiYnyJaX; Wed, 22 Jun 2022 03:22:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E803840153;
	Wed, 22 Jun 2022 03:22:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E803840153
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB5D2C0039;
	Wed, 22 Jun 2022 03:22:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DA5BC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 02:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3369E60E19
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 02:56:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3369E60E19
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eVFOr5i3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d7m5BfiqmWLH for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 02:56:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49AE560B5D
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49AE560B5D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 02:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655866581; x=1687402581;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to;
 bh=1POWSSJzqvXrAflOI6O5hwkPXEcVuX62fygc96JgKvw=;
 b=eVFOr5i3GzzPJHcydkZCCYgB8CeAlwQ2K0hLcHmbGybeSEcAjRcfBSVs
 /kC8rkUN6Knav/UDaRqnT8BPp1Q9bbxB4lJr8jpLW20ZLdgAdIN8eQNFu
 XYNC5kwpIja01Qa8cYqSeLdpkqg0kkgMDQVsSFMZ7nHY7cM+80w87+F67
 YiGM3ZXtoGzLdVkE9bLyE3HKz8uTGGsTC6lY22TcTAm/G0G8nVKYM4gVm
 0pJ71wbAT30on4sGjLL6uVrwWZMSaTjMFpSpXiPFcLQyK3I+t8CaI5g1g
 Xte+PWlSEYSxpFrFgocQelMt744L1+b3ipa9jbsVPxGyneLY3vjUR17Fq A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="366619823"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
 d="scan'208,217";a="366619823"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 19:56:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
 d="scan'208,217";a="643942407"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.210.186])
 ([10.254.210.186])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 19:56:17 -0700
Message-ID: <30d27b02-0fec-d595-75a0-155eee1c84d6@linux.intel.com>
Date: Wed, 22 Jun 2022 10:56:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix RID2PASID setup failure
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220620081729.4610-1-baolu.lu@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20220620081729.4610-1-baolu.lu@linux.intel.com>
X-Mailman-Approved-At: Wed, 22 Jun 2022 03:22:26 +0000
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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
Content-Type: multipart/mixed; boundary="===============1429447623006911483=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============1429447623006911483==
Content-Type: multipart/alternative;
 boundary="------------6G7t7VvoDiOvTujOaZ8smH0Y"

This is a multi-part message in MIME format.
--------------6G7t7VvoDiOvTujOaZ8smH0Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi，

在 2022/6/20 16:17, Lu Baolu 写道:
> The IOMMU driver shares the pasid table for PCI alias devices. When the
> RID2PASID entry of the shared pasid table has been filled by the first
> device, the subsequent devices will encounter the "DMAR: Setup RID2PASID
> failed" failure as the pasid entry has already been marke as present. As
> the result, the IOMMU probing process will be aborted.
>
> This fixes it by skipping RID2PASID setting if the pasid entry has been
> populated. This works because the IOMMU core ensures that only the same
> IOMMU domain can be attached to all PCI alias devices at the same time.
> Therefore the subsequent devices just try to setup the RID2PASID entry
> with the same domain, which is negligible.
     We have two customers reported the issue "DMAR: Setup RID2PASID 
failed",

Two ASPEED devices locate behind one PCIe-PCI bridge and iommu SM, PT 
mode is enabled.  Most

Interesting thing is the second device is only used by BIOS, and BIOS 
left it to OS without shutting down,

and it is useless for OS.  Is there practical case multi devices behind 
PCIe-PCI bridge share the same

PASID entry without any security concern ? these two customer's case is 
not.


Thanks,

Ethan

>
> Fixes: ef848b7e5a6a0 ("iommu/vt-d: Setup pasid entry for RID2PASID support")
> Reported-by: Chenyi Qiang<chenyi.qiang@intel.com>
> Cc:stable@vger.kernel.org
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 44016594831d..b9966c01a2a2 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2564,7 +2564,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
>   			ret = intel_pasid_setup_second_level(iommu, domain,
>   					dev, PASID_RID2PASID);
>   		spin_unlock_irqrestore(&iommu->lock, flags);
> -		if (ret) {
> +		if (ret && ret != -EBUSY) {
>   			dev_err(dev, "Setup RID2PASID failed\n");
>   			dmar_remove_one_dev_info(dev);
>   			return ret;

-- 
AFAIK = As Far As I Know
AKA = Also Known As
ASAP = As Soon As Possible
BTW = By The Way (used to introduce some piece of information or question that is on a different topic but may be of interest)
COLA = comp.os.linux.announce (newsgroup)
ETA = Estimated Time of Arrival
FAQ = Frequently Asked Question
FUD = Fear, Uncertainty and Doubt
FWIW = For What It's Worth
FYI = For Your Information
IANAL = I Am Not A Lawyer
IIRC = If I Recall Correctly
IMHO = In My Humble Opinion
IMNSHO = In My Not-So-Humble Opinion
IOW = In Other Words
LART = Luser Attitude Readjustment Tool (quoting Al Viro: "Anything you use to forcibly implant the clue into the place where luser's head is")
LUSER = pronounced "loser", a user who is considered to indeed be a loser (idiot, drongo, wanker, dim-wit, fool, etc.)
OTOH = On The Other Hand
PEBKAC = Problem Exists Between Keyboard And Chair
ROTFL = Rolling On The Floor Laughing
RSN = Real Soon Now
RTFM = Read The Fucking Manual (original definition) or Read The Fine Manual (if you want to pretend to be polite)
TANSTAAFL = There Ain't No Such Thing As A Free Lunch (contributed by David Niemi, quoting Robert Heinlein in his science fiction novel 'The Moon is a Harsh Mistress')
THX = Thanks (thank you)
TIA = Thanks In Advance
WIP = Work In Progress
WRT = With Respect To

--------------6G7t7VvoDiOvTujOaZ8smH0Y
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi，</p>
    <div class="moz-cite-prefix">在 2022/6/20 16:17, Lu Baolu 写道:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20220620081729.4610-1-baolu.lu@linux.intel.com">
      <pre class="moz-quote-pre" wrap="">The IOMMU driver shares the pasid table for PCI alias devices. When the
RID2PASID entry of the shared pasid table has been filled by the first
device, the subsequent devices will encounter the "DMAR: Setup RID2PASID
failed" failure as the pasid entry has already been marke as present. As
the result, the IOMMU probing process will be aborted.

This fixes it by skipping RID2PASID setting if the pasid entry has been
populated. This works because the IOMMU core ensures that only the same
IOMMU domain can be attached to all PCI alias devices at the same time.
Therefore the subsequent devices just try to setup the RID2PASID entry
with the same domain, which is negligible.</pre>
    </blockquote>
        We have two customers reported the issue "DMAR: Setup RID2PASID
    failed", <br>
    <p>Two <span
        style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;
mso-fareast-font-family:等线;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;
        mso-bidi-language:AR-SA">ASPEED devices locate behind one
        PCIe-PCI bridge and iommu SM, PT mode is enabled.  Most</span></p>
    <p><span
        style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;
mso-fareast-font-family:等线;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;
        mso-bidi-language:AR-SA">Interesting thing is the second device
        is only used by BIOS, and BIOS left it to OS without shutting
        down,</span></p>
    <p><span
        style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;
mso-fareast-font-family:等线;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;
        mso-bidi-language:AR-SA">and it is useless for OS.  Is there
        practical case multi devices behind PCIe-PCI bridge share the
        same <br>
      </span></p>
    <p><span
        style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;
mso-fareast-font-family:等线;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;
        mso-bidi-language:AR-SA">PASID entry without any security
        concern ? these two customer's case is not. <br>
      </span></p>
    <p><span
        style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;
mso-fareast-font-family:等线;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;
        mso-bidi-language:AR-SA"><br>
      </span></p>
    <p><span
        style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;
mso-fareast-font-family:等线;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;
        mso-bidi-language:AR-SA">Thanks,</span></p>
    <p><span
        style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;
mso-fareast-font-family:等线;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;
        mso-bidi-language:AR-SA">Ethan</span></p>
    <blockquote type="cite"
      cite="mid:20220620081729.4610-1-baolu.lu@linux.intel.com">
      <pre class="moz-quote-pre" wrap="">

Fixes: ef848b7e5a6a0 ("iommu/vt-d: Setup pasid entry for RID2PASID support")
Reported-by: Chenyi Qiang <a class="moz-txt-link-rfc2396E" href="mailto:chenyi.qiang@intel.com">&lt;chenyi.qiang@intel.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Signed-off-by: Lu Baolu <a class="moz-txt-link-rfc2396E" href="mailto:baolu.lu@linux.intel.com">&lt;baolu.lu@linux.intel.com&gt;</a>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 44016594831d..b9966c01a2a2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2564,7 +2564,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
 		spin_unlock_irqrestore(&amp;iommu-&gt;lock, flags);
-		if (ret) {
+		if (ret &amp;&amp; ret != -EBUSY) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
 			return ret;
</pre>
    </blockquote>
    <pre class="moz-signature" cols="72">-- 
AFAIK = As Far As I Know
AKA = Also Known As
ASAP = As Soon As Possible
BTW = By The Way (used to introduce some piece of information or question that is on a different topic but may be of interest)
COLA = comp.os.linux.announce (newsgroup)
ETA = Estimated Time of Arrival
FAQ = Frequently Asked Question
FUD = Fear, Uncertainty and Doubt
FWIW = For What It's Worth
FYI = For Your Information
IANAL = I Am Not A Lawyer
IIRC = If I Recall Correctly
IMHO = In My Humble Opinion
IMNSHO = In My Not-So-Humble Opinion
IOW = In Other Words
LART = Luser Attitude Readjustment Tool (quoting Al Viro: "Anything you use to forcibly implant the clue into the place where luser's head is")
LUSER = pronounced "loser", a user who is considered to indeed be a loser (idiot, drongo, wanker, dim-wit, fool, etc.)
OTOH = On The Other Hand
PEBKAC = Problem Exists Between Keyboard And Chair
ROTFL = Rolling On The Floor Laughing
RSN = Real Soon Now
RTFM = Read The Fucking Manual (original definition) or Read The Fine Manual (if you want to pretend to be polite)
TANSTAAFL = There Ain't No Such Thing As A Free Lunch (contributed by David Niemi, quoting Robert Heinlein in his science fiction novel 'The Moon is a Harsh Mistress')
THX = Thanks (thank you)
TIA = Thanks In Advance
WIP = Work In Progress
WRT = With Respect To</pre>
  </body>
</html>

--------------6G7t7VvoDiOvTujOaZ8smH0Y--

--===============1429447623006911483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1429447623006911483==--
