Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CD7C433EF
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 18:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F1E6409E5;
	Wed, 18 May 2022 18:42:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YZcJU4URtoML; Wed, 18 May 2022 18:42:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 005BB41C3D;
	Wed, 18 May 2022 18:42:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E8DFC0032;
	Wed, 18 May 2022 18:42:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83527C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7192C61255
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=hpe.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QZRoVC-P7Idp for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:42:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87C2C61254
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:42:12 +0000 (UTC)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IHeIYV031831;
 Wed, 18 May 2022 18:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=JkdAJp6/nFA0fMkh73Q6AHAhW3P+czhEF0OIA1t5HCg=;
 b=Qg2AhnHrd3KBRi0DM+Bb3C5HbTo+NMkyfHHtmg++jWG9ug+/mnlUut0DeIcgWTWtI//2
 HI6OjGG/DUrRPlT32fATsiDynZSEP+I3w0v6l2juXvPIUAPpeADtplpUS+ptlXAG3tFI
 d+t4fePOEIgxlDSGArqM8HgF2nYdi2nUvcC2nqJrCqM0ypC9/4655ZTL2f9YPksE/jl9
 Pk3xAGjSmX8pnhrRgS8KClB67yDFV7hx7UFCHMQdsGNdGQJ/6nj1PWHFv/lgNkyS2s5D
 Y/H7skS6+Wn3n5hPvTuDy+i9B1Wm4vBh0lEx/9u2lMfxgj8ZWjloLXNVjOBm7tCsCmxE fQ== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com
 [15.241.140.73])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g52ynjr3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 May 2022 18:41:29 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net
 [16.208.49.245])
 by g4t3427.houston.hpe.com (Postfix) with ESMTP id A42CD57;
 Wed, 18 May 2022 18:41:28 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [10.207.216.251])
 by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id CAE565B;
 Wed, 18 May 2022 18:41:25 +0000 (UTC)
Date: Wed, 18 May 2022 13:41:25 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/7] iommu/vt-d: Make intel-iommu.h private
Message-ID: <YoU91f2ncSkJP27T@swahl-home.5wahls.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
X-Proofpoint-GUID: eeDz9k6Fyio9EZLTXEQmcX-SiAr354e5
X-Proofpoint-ORIG-GUID: eeDz9k6Fyio9EZLTXEQmcX-SiAr354e5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 bulkscore=0 mlxlogscore=648 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180108
Cc: Steve Wahl <steve.wahl@hpe.com>, David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Ashok Raj <ashok.raj@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Ning Sun <ning.sun@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Borislav Petkov <bp@alien8.de>, Robin Murphy <robin.murphy@arm.com>
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

On Sat, May 14, 2022 at 09:43:15AM +0800, Lu Baolu wrote:
> Hi folks,
> 
> The include/linux/intel-iommu.h should be private to the Intel IOMMU
> driver. Other drivers or components should interact with the IOMMU
> drivers through the kAPIs provided by the iommu core.
> 
> This series cleanups all includes of intel-iommu.h outside of the Intel
> IOMMU driver and move this header from include/linux to
> drivers/iommu/intel/.
> 
> No functional changes intended. Please help to review and suggest.

I went through and examined the changes as well.  These changes make the
robots complaint against my patch go away, which is great by me!

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

-- 
Steve Wahl, Hewlett Packard Enterprise
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
