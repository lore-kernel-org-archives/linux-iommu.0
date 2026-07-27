Received: from out16-31.antispamcloud.com (out16-31.antispamcloud.com [185.201.18.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07223DEFF1;
	Mon, 27 Jul 2026 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.18.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192235; cv=none; b=NJxvl2fOeuh7Nqo8iloc4ppgrqoPVD9WANja7viEJfQNP+HISBvGtpT6GNH5i+oZ09VZL0bpkfF7jP/vlYCFeZiKQhpuZNWKy7Xpmg9Ciz7JFpT7+N8j/R8ul4Z3A95YSqSiakwXI7h8fWccdMx4UH8hO4WnGbbhaVcW88Hwwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192235; c=relaxed/simple;
	bh=O6AzFowVp4RNTv/18UxgNKW99tk5vhZwXgSFT5MPAWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoFjX91SUfCYXMhm9C2S1Eg5Qtky2pCIqGPRv9c6LAncdHtujxClpI4JXshP+a6EAfcqqOl3XmoJBOZkNA9xTen+1O8APgdA20gtPcr9U5BewPA4s3QPcLUeI5Ojh0LgNk0YhuK/AvLfAfSPAaoEAMKRl7diTt8aTx6Ghp2XsE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=xKzrLGTC; arc=none smtp.client-ip=185.201.18.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="xKzrLGTC"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx198.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1woSC0-00FDyW-1i; Mon, 27 Jul 2026 22:45:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gXGy0SHh8jrpSx+7uq/1tK4RtoEe8AnmCidff/RRwQA=; b=xKzrLGTCjD0Wvn8T+2CSK9mmEP
	5gbte8SftUeRnlxAxEqHb0B26+LrCi46ypwLbXHFqIeFqsadp32pbjWpGAljUAdCCDCfPIlxrkV0m
	eyg/cpQlU1hhzyjDxvuPE045aHjivZXnIQU1LgXrRjJJoqzCkGANWLd8aN+xar40oEvURFxakr97W
	uSHPotntrvNVOu5fnKR2HNsayjhsDn5q1XNSYUbNa6A3lPsfdkMLRhNjKxUViYdsOiC+TkRY94xw6
	OaR2G3A+jJGvgz2jcXnjGXFESJf3VXi5vKUnJkwSUi4CvuSgnSQjpqQsvt6KQwzc7wL9KP5vjdrdE
	M4WZHVgQ==;
Received: from [188.251.249.2] (port=52006 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <dan@reactivated.net>)
	id 1woSBv-0000000AlhO-40wY;
	Mon, 27 Jul 2026 20:44:51 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Mon, 27 Jul 2026 21:43:56 +0100
Subject: [PATCH v2 1/5] generic_pt: allow missing sw bit in DMA_INCOHERENT
 case
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-bcm2712-iommu-submit-v2-1-0247b5c03de8@reactivated.net>
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
In-Reply-To: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Daniel Drake <dan@reactivated.net>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.3
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUrXUfs4B29vl3sm0928Wg7TGSVRZSTQZ6D
 d1+lfooj8iu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIM9P/1xMDIkquwg7ai9+tqqGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWAIN4GsiK0O3K+JEByc7IobeB7itP8hgjDRserKv4bhb/pXHHNX+LCF5x5jewa7FkNWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKclZzoe+TZdeH39wA4E
 grA4pE2PuLHIFQdBY9qb1rRWgyz0f29FZkQs6Ir87R/YNAsKIxDIUtFmywXPGNvcLD4XAsy6ZgPN
 XtV1vaLx7+UgEWK01AxdI+KkSxKhiIoeJ0jQMvgrc1wie1AEvvcTmPTytX698+ztXsH6JaapNvQF
 04irJjZh1zuwKVTcv9YdmjlVE03CQCv1OPOxZ3EyKTJGzDaNnaI/TSpIu7J1HoIZoPraGaqADwsr
 hpLSznzcewLJhIQpMZXNN5waPWBxruZklS+QlzUpPwM5oicrBfHSx0cq8sPOf6wGW9u/lWd24hqp
 yYmhcu01nwGh48ZvjBXmHyxxk8Sjs3o9/k8nLBnptL51csmNAdXgD5+6bU9gO3ZLn/njN5eSj526
 f3kLYY1T/P2g+PQ+l1DstpeYEVfxMxGAKIaxTMjXXNk1i3Bzs815ElLTCa2tTtJNS6kAj74zV8Jw
 2Fxq1Vd7xIu/TP3zx09ZxKUjiSltDxNYVDOGVSYSMZzCFfNlTB1XVH7neYUsHgYpny0exHkD4v2T
 MMb8rpk5QFK0AS+w7oZEh675gBR0cXT+dF0NxOWKiLIVw46C5KEt00Sv6nHHHAoc3/Q83cLqzhpS
 0znDaGCPRF8atS6+/IVQTbUJupnRiHmHNLRPMKbVSbsDMLsDJjzehgqGk6S9HXdEGxiktrX59Amx
 O5gvPpyylyRksDtvh9EglVwlXarBbY/5t7CstIBQE8o/YSFDpQ3A7hHzYZTDTFQbY0uqoOhT9kj8
 8PvWZJaonRQv++DuIQUs/5JJj4C/n4CILhif+3TxP9sd7y15THR2QZzkg3RQrvacrkZ+DYAj4Ojj
 HQAEwWflr/1yylAR2QMesXOVLbMF4pTjWB0otgBwB1GjG9/7eW4VzmKFOpkivUGpcgYFRrqmiqIy
 cv2/2+nkpYsEMysPur9wmiDBurOy6iR92AkV20DuvQ+xF0HoW5AQikKYGfM1Wxpi+aM7bRAnIOLo
 KQ0J9yQ0dfrf1qMUYpmRgnAod+6ZVPr8gZAM4Wbf+qcjHi4H/kJJ2RqjS9NOIeNn/VZF/HyORicl
 1WGsneIWpF1Xu3oZ/FZQiE2Ny7dG9R/2gMGq0KWAzmMf+ibVDnUBndNaXaq/kyxZOii4y6zwY127
 8R9pzC31fkjBqL4nASEz1JNCESIPL2LJqBM7qaqIrXo0c6G6fvFF//i6zRUhEWyJzIkwSFAW0Pw8
 uiKeSByqtznmWyRPJzMvReGPtOJKZj6+qwdjWpxBAv2JzzLwY1278R9pzC31fkjBqL4n6ihrjW1z
 DU0jv8+sl3B5Xg==
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

When working with a iommu with PT_FEAT_DMA_INCOHERENT set, generic_pt
will attempt to use a spare "SW" bit in the hardware page tables to
denote when a thread has flushed the CPU cache after modifying an entry.
This means that other threads know that they are not working with
cached/unflushed data, if they come across the same entry.

In the case where no SW bit is implemented, an undefined reference to
__pt_no_sw_bit() is created, causing a linker error in order to prompt
the developer to implement this feature.

For BCM2712 IOMMU, no SW bit is available at the hardware level, so we now
need to permit this case.

Introduce a PT_FEAT_NO_SW_BIT flag to allow for this: this will avoid the
sw_bit codepaths, so no undefined reference is created. __map_range() will
fall back to defensive flushing every time it reads the PT, ensuring
that all data that may have just been manipulated by another thread gets
flushed and made iommu-visible immediately.

Signed-off-by: Daniel Drake <dan@reactivated.net>
---
 drivers/iommu/generic_pt/iommu_pt.h        | 13 ++++++++-----
 drivers/iommu/generic_pt/pt_fmt_defaults.h |  7 +++++++
 include/linux/generic_pt/common.h          |  7 +++++++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index c2752151c80a..54f9c311d0ac 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -484,7 +484,8 @@ static inline int pt_iommu_new_table(struct pt_state *pts,
 
 	if (pts_feature(pts, PT_FEAT_DMA_INCOHERENT)) {
 		flush_writes_item(pts);
-		pt_set_sw_bit_release(pts, SW_BIT_CACHE_FLUSH_DONE);
+		if (!pts_feature(pts, PT_FEAT_NO_SW_BIT))
+			pt_set_sw_bit_release(pts, SW_BIT_CACHE_FLUSH_DONE);
 	}
 
 	if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
@@ -702,10 +703,12 @@ static int __map_range(struct pt_range *range, void *arg, unsigned int level,
 			 * release of the cache flush so that this can acquire
 			 * visibility at the iommu.
 			 */
-			if (pts_feature(&pts, PT_FEAT_DMA_INCOHERENT) &&
-			    !pt_test_sw_bit_acquire(&pts,
-						    SW_BIT_CACHE_FLUSH_DONE))
-				flush_writes_item(&pts);
+			if (pts_feature(&pts, PT_FEAT_DMA_INCOHERENT)) {
+				if (pts_feature(&pts, PT_FEAT_NO_SW_BIT) ||
+				    !pt_test_sw_bit_acquire(&pts,
+							    SW_BIT_CACHE_FLUSH_DONE))
+					flush_writes_item(&pts);
+			}
 		}
 
 		/*
diff --git a/drivers/iommu/generic_pt/pt_fmt_defaults.h b/drivers/iommu/generic_pt/pt_fmt_defaults.h
index 69fb7c2314ca..72f341645294 100644
--- a/drivers/iommu/generic_pt/pt_fmt_defaults.h
+++ b/drivers/iommu/generic_pt/pt_fmt_defaults.h
@@ -249,6 +249,13 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common)
 	return 0;
 }
 
+/*
+ * In the DMA_INCOHERENT case, if no SW bit has been defined, produce a linker
+ * error (undefined symbol __pt_no_sw_bit) to alert the developer that this
+ * should be implemented. Alternatively, if this is not supported by the
+ * underlying hardware, PT_FEAT_NO_SW_BIT can be set, enabling sw-bit-less
+ * operation with a defensive flushing performance penalty.
+ */
 extern void __pt_no_sw_bit(void);
 static inline bool pt_test_sw_bit_acquire(struct pt_state *pts,
 					  unsigned int bitnr)
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index 07ef1c8341a4..9e8001f7b069 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -139,6 +139,13 @@ enum pt_features {
 	 * sub structure with information about which levels were changed.
 	 */
 	PT_FEAT_DETAILED_GATHER,
+	/**
+	 * @PT_FEAT_NO_SW_BIT: No software bit is available to denote when a
+	 * thread has flushed the CPU cache after modifying an entry. Only
+	 * set this if you cannot implement pt_sw_bit() due to hardware
+	 * limitations.
+	 */
+	PT_FEAT_NO_SW_BIT,
 	/* private: */
 	PT_FEAT_FMT_START,
 };

-- 
2.55.0

