Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA58C433EF
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 19:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CBB4840930;
	Wed, 18 May 2022 19:59:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x3ODzioR9u0o; Wed, 18 May 2022 19:59:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD38B40155;
	Wed, 18 May 2022 19:59:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AC3EC0039;
	Wed, 18 May 2022 19:59:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE1BAC002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 19:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACC3041B9C
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 19:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=hpe.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ssz8dfKZ2vVz for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 19:59:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DE3D41B8F
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 19:59:39 +0000 (UTC)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IJ20Eh031668;
 Wed, 18 May 2022 19:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=NMq5uB0MTUMudjGBVLDD0OXDum4Fof15hbz7EILKipA=;
 b=S9/BQaeS5Y7O2ldOLm8s2/g8bgN51M5WxJf4bH5UKRkYtHACbJaQPeulatNDG+qI1LUD
 Tv48Hy3xuNThQ4WluRIbdLewM0Bo6/rug1nBQcYtfi/L/RbZCaHt5MhrKxjmZmCgrpjf
 y9dv5iucW18UJvXcREecqf2TthV14woPYN/u+AkwgN/WbQxDn2CnbPREN7HLGNftd4cF
 0OiA5K+9BnCnf6ClLgsB2rXXMWdC/ml3Qre2mTUhr3Rdnt79l+r6d2Ga1lTqAczvTxPN
 ygvzfQi08JEwpF3IupvGZmLglUBO5DGif02YBuNU8+uhb2cmiYJeXpEHBzVSiy558fhG rQ== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com
 [15.241.140.78])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3g4rvbuju6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 May 2022 19:58:27 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net
 [16.220.97.129])
 by g4t3425.houston.hpe.com (Postfix) with ESMTP id 2C7A7A8;
 Wed, 18 May 2022 19:58:26 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [10.207.216.251])
 by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id E645C4E;
 Wed, 18 May 2022 19:58:23 +0000 (UTC)
Date: Wed, 18 May 2022 14:58:23 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <YoVP3w5cJWriLBlu@swahl-home.5wahls.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <Yn2UYst0ETp42uzq@swahl-home.5wahls.com>
 <2c65b8cf-3813-3ddf-3f5b-c374cc842678@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c65b8cf-3813-3ddf-3f5b-c374cc842678@linux.intel.com>
X-Proofpoint-ORIG-GUID: bAtMyue4fwEGQiU_GnCx-nmpbuHsVI6G
X-Proofpoint-GUID: bAtMyue4fwEGQiU_GnCx-nmpbuHsVI6G
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=701 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180117
Cc: Dimitri Sivanich <sivanich@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Russ Anderson <russ.anderson@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On Fri, May 13, 2022 at 10:09:46AM +0800, Baolu Lu wrote:
> On 2022/5/13 07:12, Steve Wahl wrote:
> > On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> > > To support up to 64 sockets with 10 DMAR units each (640), make the
> > > value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> > > CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> > > set.
> > > 
> > > If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> > > to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> > > allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> > > remapping doesn't support X2APIC mode x2apic disabled"; and the system
> > > fails to boot properly.
> > > 
> > > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > 
> > I've received a report from the kernel test robot <lkp@intel.com>,
> > that this patch causes an error (shown below) when
> > CONFIG_IOMMU_SUPPORT is not set.
> > 
> > In my opinion, this is because include/linux/dmar.h and
> > include/linux/intel-iommu are being #included when they are not really
> > being used.
> > 
> > I've tried placing the contents of intel-iommu.h within an #ifdef
> > CONFIG_INTEL_IOMMU, and that fixes the problem.
> > 
> > Two questions:
> > 
> > A) Is this the desired approach to to the fix?
> 
> Most part of include/linux/intel-iommu.h is private to Intel IOMMU
> driver. They should be put in a header like drivers/iommu/intel
> /iommu.h. Eventually, we should remove include/linux/intel-iommu.h
> and device drivers interact with iommu subsystem through the IOMMU
> kAPIs.
> 
> Best regards,
> baolu

Baolu's recent patch to move intel-iommu.h private still allows my
[PATCH v2] to apply with no changes, and gets rid of the compile
errors when CONFIG_IOMMU_SUPPORT is not set, so the kernel test robot
should be happy now.

Is there another step I should do to bring this patch back into focus?

Thanks.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
