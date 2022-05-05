Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF2DC433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 20:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DE958406C;
	Thu,  5 May 2022 20:18:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id viOM-_irL2fC; Thu,  5 May 2022 20:18:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6DB9B84061;
	Thu,  5 May 2022 20:18:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43B11C0039;
	Thu,  5 May 2022 20:18:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 240CEC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 20:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03AF14049E
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 20:09:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=hpe.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7lE6tVuQS0aH for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 20:09:00 +0000 (UTC)
X-Greylist: delayed 00:21:35 by SQLgrey-1.8.0
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 175EF4011F
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 20:08:59 +0000 (UTC)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245FhOpo003652;
 Thu, 5 May 2022 19:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=C3QEOZbwGY5sXGcx1EpjDtWP0ojZE1TLeKrfEOzEke0=;
 b=VF2gFtW6wqp/nmndXtcLTS/8b435NXPUh13SQhzacfCr3W3akrSKQapAdF64ArztphY4
 zbAWp8V6BzBtWiyqY17nbTIF1VFIq6KejA37pnMzhRafKZ99klqNW8HZ0T0cF0Vl/gpW
 jBw8pSyWNysnS6998PFZRzsnR15rNSGOAT0eMu4cWrs7OMHo5JqJEZ8voBiBkBoBbl0z
 ljEIRCzGNL88Pu/wv52ZwS5gfX+7BYHXArJbj4s4WYF5+7+6GchByksxNx73GYU18PCq
 ojIz7rCNYn4dYjaPBSDI8LIvD/oa0o41nf93PwMhP7JnuRmROKt2w5oHLO0h7GQ24FgS ZA== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com
 [15.241.140.73])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fvhfd2336-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 May 2022 19:47:00 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net
 [16.220.97.129])
 by g4t3427.houston.hpe.com (Postfix) with ESMTP id 346D25E;
 Thu,  5 May 2022 19:46:59 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net
 [128.162.243.181])
 by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 7FB9E4D;
 Thu,  5 May 2022 19:46:58 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
 id 275CF30193E67; Thu,  5 May 2022 14:46:58 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Joerg Roedel <jroedel@suse.de>, Kyung Min Park <kyung.min.park@intel.com>, 
 Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Date: Thu,  5 May 2022 14:46:58 -0500
Message-Id: <20220505194658.246121-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: ZiQt0AfFhekgODgw_TIdFOWhuDP_me1a
X-Proofpoint-GUID: ZiQt0AfFhekgODgw_TIdFOWhuDP_me1a
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_08,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050131
X-Mailman-Approved-At: Thu, 05 May 2022 20:18:30 +0000
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

Increase DMAR_UNITS_SUPPORTED to support 64 sockets with 10 DMAR units
each, for a total of 640.

If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
remapping doesn't support X2APIC mode x2apic disabled"; and the system
fails to boot.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Mike Travis <mike.travis@hpe.com>
---

Note that we could not find a reason for connecting
DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
it seemed like the two would continue to match on earlier processors.
There doesn't appear to be kernel code that assumes that the value of
one is related to the other.

 include/linux/dmar.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 45e903d84733..9d4867b8f42e 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -19,7 +19,7 @@
 struct acpi_dmar_header;
 
 #ifdef	CONFIG_X86
-# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
+# define	DMAR_UNITS_SUPPORTED	640
 #else
 # define	DMAR_UNITS_SUPPORTED	64
 #endif
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
