Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3F4582FF
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389800; cv=none; b=L4bGiJR/8JqHQBgrxNlUh6qUX7JvX4zYffJlEEpVGWlji9pp2S9wNggyDoUeGMyOoCfoa1C2RQyZ2x5yQLrO6PBo9iOVPF/3STHhFSgqbYdyVNjtKayPaFHB7hMiTjjBqSVmMETFM3XtA1yd2Cfc55JM3WQHg2AthuFWQcthIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389800; c=relaxed/simple;
	bh=DyJgJINGrj/Oi16BQyI0xHNXSqfTphHOzT8kolkMIn4=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=HcmLYN1jvasgP2fKUbR17zu5IZfE9Xdltomu9kj+eq5PXxLErXUMjXe6rGxw8ywJ+AA15FztPKn3G7GnKJIk4M7KeV2Gp58NBVI4cfbbY9vkRc6RKCZve3XGJb7EUXlBArhFghBODqMcvYT9sR3gNXgJfoWSonxUxirEmtLjCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e15QDmOc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e15QDmOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789389796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yh4LTMrVgvTWawuhXeGz+7PzkeHy1e2QB0EjAsyshR4=;
	b=e15QDmOcFtc3OtxNQrnPHei/Rhe9hr96HNkkx9JcMOzWAN2DWIYi3dggeB2pPsxrNz+RFI
	QQX6zw9BEJ9XqlQYM1UcnCrZxZzbQStZEaMcBCYodck7Dmzz6M+vLBMnqrUZFFkN7nLWLW
	MbpBqKUcDywn2buAcq/MWMDT4M8QW4s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-59vNceDqPHq69LGJRdG_wg-1; Mon,
 14 Sep 2026 08:43:14 -0400
X-MC-Unique: 59vNceDqPHq69LGJRdG_wg-1
X-Mimecast-MFC-AGG-ID: 59vNceDqPHq69LGJRdG_wg_1789389789
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79B3419560B7;
	Mon, 14 Sep 2026 12:43:08 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57E2F426;
	Mon, 14 Sep 2026 12:42:56 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 14 Sep 2026 14:41:56 +0200
Subject: [PATCH 3/3] firmware: qcom: scm: drop the __scm global
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260914-scm-device-api-v1-3-3573e2596c51@redhat.com>
References: <20260914-scm-device-api-v1-0-3573e2596c51@redhat.com>
In-Reply-To: <20260914-scm-device-api-v1-0-3573e2596c51@redhat.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Russell King <linux@armlinux.org.uk>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jeff Johnson <jjohnson@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, 
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Govind Singh <govinds@codeaurora.org>, 
 Niklas Cassel <niklas.cassel@linaro.org>, Kalle Valo <kvalo@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-gpio@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 op-tee@lists.trustedfirmware.org, Maxime Ripard <mripard@kernel.org>, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789389733; l=3324;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=DyJgJINGrj/Oi16BQyI0xHNXSqfTphHOzT8kolkMIn4=;
 b=2E/njtRQDI7qg6KhOX02E6Kl8NSZnKke0TKHePsDGKL5/0MukpgBGJfWN70DxUsg7WRIuQpoA
 /xIDnhDFsgGDyONBfr/Sih+/SjlyEaAmyySnb2O8dlDdWfLuFgovspB
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cwRZwxmBlfSyV8PDZXF7lliRc1bzpPBlCQ6Eq5QXdNY_1789389789
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Stop publishing a driver-wide singleton. Mark the instance
ready with scm->available, look it up from the platform driver
for module-parameter stores, and use platform_get_drvdata() on
shutdown.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/firmware/qcom/qcom_scm.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 73e9752e3cca..68cd8dc622c6 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -63,6 +63,9 @@ struct qcom_scm {
 
 	struct qcom_tzmem_pool *mempool;
 	unsigned int wq_cnt;
+
+	/* Published with smp_store_release() once the SCM API is usable. */
+	int available;
 };
 
 struct qcom_scm_current_perm_info {
@@ -174,8 +177,6 @@ static const char * const download_mode_name[] = {
 	[QCOM_DLOAD_BOTHDUMP]	= "full,mini",
 };
 
-static struct qcom_scm *__scm;
-
 static int qcom_scm_clk_enable(struct qcom_scm *scm)
 {
 	int ret;
@@ -1962,7 +1963,7 @@ EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
  * This is only supposed to be called once by the TZMem module. It takes the
  * SCM struct device as argument and uses it to pass the call as at the time
  * the SHM Bridge is enabled, the SCM is not yet fully set up and doesn't
- * accept global user calls. Don't try to use the __scm pointer here.
+ * accept global user calls.
  */
 int qcom_scm_shm_bridge_enable(struct device *scm_dev)
 {
@@ -2657,7 +2658,7 @@ static void qcom_scm_qtee_init(struct qcom_scm *scm)
 bool qcom_scm_is_available(struct qcom_scm *scm)
 {
 	/* Paired with smp_store_release() in qcom_scm_probe */
-	return scm && scm == smp_load_acquire(&__scm);
+	return scm && smp_load_acquire(&scm->available);
 }
 EXPORT_SYMBOL_GPL(qcom_scm_is_available);
 
@@ -2817,7 +2818,7 @@ static int set_download_mode(const char *val, const struct kernel_param *kp)
 
 	download_mode = ret;
 	/* Pairs with smp_store_release() in qcom_scm_probe(). */
-	scm = smp_load_acquire(&__scm);
+	scm = qcom_scm_get();
 	if (scm)
 		qcom_scm_set_download_mode(scm, download_mode);
 
@@ -2858,7 +2859,7 @@ static int set_minidump_dest(const char *val, const struct kernel_param *kp)
 	minidump_dest = minidump_dest_map[i].val;
 
 	/* Pairs with smp_store_release() in qcom_scm_probe(). */
-	scm = smp_load_acquire(&__scm);
+	scm = qcom_scm_get();
 	if (scm && scm->minidump_sram && (download_mode & QCOM_DLOAD_MINIDUMP))
 		writel_relaxed(minidump_dest, scm->minidump_sram);
 
@@ -2983,7 +2984,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	 * be called after the TrustZone memory pool is initialized and the
 	 * waitqueue interrupt requested.
 	 */
-	smp_store_release(&__scm, scm);
+	smp_store_release(&scm->available, 1);
 
 	__get_convention(scm->dev);
 
@@ -3033,8 +3034,10 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
+	struct qcom_scm *scm = platform_get_drvdata(pdev);
+
 	/* Clean shutdown, disable download mode to allow normal restart */
-	qcom_scm_set_download_mode(__scm, QCOM_DLOAD_NODUMP);
+	qcom_scm_set_download_mode(scm, QCOM_DLOAD_NODUMP);
 	qcom_pas_ops_unregister();
 }
 

-- 
2.55.0

