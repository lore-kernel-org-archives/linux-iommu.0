Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1731C433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 23:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75AF241680;
	Thu, 12 May 2022 23:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id enIYlzr_G38v; Thu, 12 May 2022 23:12:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F1DE54167A;
	Thu, 12 May 2022 23:12:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF092C0032;
	Thu, 12 May 2022 23:12:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C00FC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 23:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 435B9825C6
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 23:12:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=hpe.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B8a2lLYBDXSc for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 23:12:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBEBB82572
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 23:12:45 +0000 (UTC)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CGAvuE005052;
 Thu, 12 May 2022 23:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=LZVNUAIDSEu9/DVKOuoRKSe4j+omN8ZwfLvyP3Uyqtk=;
 b=Qb+tNSdQT7hymKCR9HlYUSIkuDzcjrIbWaz3Q6NpRIhiioIA9m7caMHIdR85nqJVQwA7
 dNuWVTGB/WF+BUO9SicLTOY8oQLmSpqiHKnDe1YdrU2mmFn7MtKwCRyWjQ56JFJ19/Pq
 6E10TGFND7eNEqmoac9Vr/tdArfn1wYxJzyU71zlqBqm+wnEKuQX7vX7mHXgwtX3bQx4
 ljjdKQyamhLTwT9m5wbr1HsbqdF69/Tvt/aK8TEoNNaXxyAMPu0CEPbWAZ1SgSvz4Z51
 8D58dgXkphcLs/uDlEKFhcPu4sm0xj0aPWbgqoBgN5Xbo7tjX2hJ3o9dJvE1z/S8hKKO 7Q== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com
 [15.241.140.73])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3g0h2s4dr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 May 2022 23:12:37 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net
 [16.208.49.245])
 by g4t3427.houston.hpe.com (Postfix) with ESMTP id 6BD3257;
 Thu, 12 May 2022 23:12:36 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [10.207.206.199])
 by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id EC24445;
 Thu, 12 May 2022 23:12:34 +0000 (UTC)
Date: Thu, 12 May 2022 18:12:34 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Joerg Roedel <jroedel@suse.de>, Kyung Min Park <kyung.min.park@intel.com>, 
 Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <Yn2UYst0ETp42uzq@swahl-home.5wahls.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220512151309.330068-1-steve.wahl@hpe.com>
X-Proofpoint-GUID: Bn27EBR5OzO3pAHxn15TKeA1h62Kv1Uq
X-Proofpoint-ORIG-GUID: Bn27EBR5OzO3pAHxn15TKeA1h62Kv1Uq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_19,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=755 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120098
Cc: Mike Travis <mike.travis@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
 linux-kernel@vger.kernel.org, Russ Anderson <russ.anderson@hpe.com>,
 Steve Wahl <steve.wahl@hpe.com>
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

On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> To support up to 64 sockets with 10 DMAR units each (640), make the
> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> set.
> 
> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> fails to boot properly.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

I've received a report from the kernel test robot <lkp@intel.com>,
that this patch causes an error (shown below) when
CONFIG_IOMMU_SUPPORT is not set.

In my opinion, this is because include/linux/dmar.h and
include/linux/intel-iommu are being #included when they are not really
being used.

I've tried placing the contents of intel-iommu.h within an #ifdef
CONFIG_INTEL_IOMMU, and that fixes the problem.

Two questions:

A) Is this the desired approach to to the fix?

B) Should it be a separate patch, or added onto this patch as a v3?

Error message:  ------------------------------

   In file included from include/linux/intel-iommu.h:21,
                    from arch/x86/kvm/x86.c:44:
>> include/linux/dmar.h:21:33: error: 'CONFIG_DMAR_UNITS_SUPPORTED' undeclared here (not in a function); did you mean 'DMAR_UNITS_SUPPORTED'?
      21 | #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/intel-iommu.h:531:35: note: in expansion of macro 'DMAR_UNITS_SUPPORTED'
     531 |         unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
         |                                   ^~~~~~~~~~~~~~~~~~~~


vim +21 include/linux/dmar.h

    20
  > 21  #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
    22

Initial stab at fixing it: ------------------------------

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2f9891cb3d00..916fd7b5bcb5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -10,6 +10,8 @@
 #ifndef _INTEL_IOMMU_H_
 #define _INTEL_IOMMU_H_
 
+#ifdef CONFIG_INTEL_IOMMU
+
 #include <linux/types.h>
 #include <linux/iova.h>
 #include <linux/io.h>
@@ -831,4 +833,6 @@ static inline const char *decode_prq_descriptor(char *str, size_t size,
 	return str;
 }
 
+#endif /* CONFIG_IOMMU_SUPPORT */
+
 #endif


Thanks.

--> Steve Wahl


-- 
Steve Wahl, Hewlett Packard Enterprise
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
