Received: from sg-1-21.ptr.blmpb.com (sg-1-21.ptr.blmpb.com [118.26.132.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D7291C3F
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567118; cv=none; b=Jqnoe2nzr8jZIUcs/EV8neoczlvHCxPCn9qvj62M6i5T7J/ouFzTMLtIpC4E2wFQWY/YB4gL011T7OYKMpR8r+/7AkU7gWQzYIobS2LzTzEuysFqa3bpc4wh7f+Sf2zX+BbcgcUMRQMa6zdeT2lchubin71yLsZ4ZSJ4WUPUfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567118; c=relaxed/simple;
	bh=1AyY4waKxYAjt+02iIIWmsyGVA6rjvGazBxFTEci1Eg=;
	h=Date:Message-Id:Mime-Version:Content-Type:From:Subject:
	 In-Reply-To:References:To:Cc; b=jaBzbZo6iXufFXc9jw1fbG+XwVc1juhQ10qU2mqjimoyZ8id7jY0wLDmqRWqxHGc5x0mwfGUH7hIdX7DanLKKYdtiqzJfXqPjYGFUP3tI2rdEEmE43tDoqgujR3tjEAUubBY+cI8IwV1fLhBzSlCXsBvaSSujQc2ZVD5NGfgny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=iBl470d+; arc=none smtp.client-ip=118.26.132.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="iBl470d+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769567104; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=mNbCdq6G9k4k3ItBCiA7OJJ5eDEPksFPc+BcVBQknZY=;
 b=iBl470d+2J2/XeOSLscCnTAPOjuIz54QTLaSFQcy6eQ/SKADoxB2sGv6JCqCRuw0LLI/X5
 B+iLr/M0Koi6MVtttTIeoZxfxYtYftJHedSZosvYJM0HlHCN7Pp9GT2VB2RTqqA8cHNAmA
 NgjG8yTXM4BU/kX0TGDkuF3ts5b0nGeotDRM4pQLfGBr0xFIF5Xhj+52EseR0dVae8nA6K
 rFqSmA6r3hJ528mbg0DVCPkLXMSKtE6viiCPG6GketOCOPzOXe/sIFxmkl+iGqBNQfGW1l
 j8IG+A4RzObk3t2rbFd1TBp1xXQHIyi21DDDvg3hKA4vVpXbrYmFQdezf8VReA==
Date: Wed, 28 Jan 2026 10:24:59 +0800
Message-Id: <cb4abe275a064f241fa54440608cd3240fb82284.1769562575.git.lv.zheng@spacemit.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
From: "Lv Zheng" <lv.zheng@spacemit.com>
Subject: [PATCH 4/6] spacemit/t100: Add vendor event support for RISC-V IOMMU HPM
In-Reply-To: <cover.1769562575.git.lv.zheng@spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
Received: from SurfaceBook2-B.localdomain ([122.224.183.70]) by smtp.feishu.cn with ESMTPS; Wed, 28 Jan 2026 10:25:02 +0800
X-Lms-Return-Path: <lba+26979737f+f4b4f3+lists.linux.dev+lv.zheng@spacemit.com>
X-Original-From: Lv Zheng <lv.zheng@spacemit.com>
To: "Robin Murphy" <robin.murphy@arm.com>, 
	"Tomasz Jeznach" <tjeznach@rivosinc.com>
Cc: "Jingyu Li" <joey.li@spacemit.com>, "Lv Zheng" <lv.zheng@spacemit.com>, 
	"Zhijian Chen" <zhijian@spacemit.com>, <iommu@lists.linux.dev>
X-Mailer: git-send-email 2.43.0

This patch adds mechanism to allow vendor events to be registered via
device tree. This is useful to support SpacemiT T100 IOMMU where the
maximum 128 event IDs should be supported by T100 IOATS.

Signed-off-by: Lv Zheng <lv.zheng@spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 .../bindings/iommu/riscv,iommu.yaml           |  4 +
 drivers/iommu/riscv/iommu-bits.h              |  2 +-
 drivers/iommu/riscv/iommu-hpm.c               | 92 ++++++++++++++++++-
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Doc=
umentation/devicetree/bindings/iommu/riscv,iommu.yaml
index d4838c3b3741..b69109362b20 100644
--- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
@@ -68,6 +68,10 @@ properties:
   power-domains:
     maxItems: 1
=20
+  vendor-hpm-events:
+    minItems: 1
+    maxItems: 120
+
 required:
   - compatible
   - reg
diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-b=
its.h
index f5f00386a11c..d85f2ae898dd 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -251,7 +251,7 @@ enum riscv_iommu_hpmevent_id {
 	RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
 	RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
 	RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
-	RISCV_IOMMU_HPMEVENT_MAX        =3D 9
+	RISCV_IOMMU_HPMEVENT_MAX        =3D 128
 };
 #define RISCV_IOMMU_HPMEVENT_CYCLES	RISCV_IOMMU_HPMEVENT_INVALID
=20
diff --git a/drivers/iommu/riscv/iommu-hpm.c b/drivers/iommu/riscv/iommu-hp=
m.c
index 3613819767f3..24da70de65fe 100644
--- a/drivers/iommu/riscv/iommu-hpm.c
+++ b/drivers/iommu/riscv/iommu-hpm.c
@@ -591,6 +591,79 @@ static void riscv_iommu_hpm_reset(struct riscv_iommu_h=
pm *iommu_hpm)
 	riscv_iommu_hpm_interrupt_clear(iommu_hpm);
 }
=20
+static int riscv_iommu_hpm_init_vendor_events(struct riscv_iommu_hpm *iomm=
u_hpm,
+					      struct attribute ***vendor_attrs)
+{
+	struct device *dev =3D iommu_hpm->iommu->dev;
+	struct device_node *np =3D dev->of_node;
+	struct perf_pmu_events_attr *vendor_event_attrs;
+	struct attribute **attrs;
+	const char *event_str;
+	int num_events, i, j;
+	char *event_copy, *colon;
+	u32 event_id;
+
+	*vendor_attrs =3D NULL;
+
+	if (!np)
+		return 0;
+
+	num_events =3D of_property_count_strings(np, "vendor-hpm-events");
+	if (num_events <=3D 0)
+		return 0;
+
+	attrs =3D devm_kcalloc(dev, num_events + 1, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+	vendor_event_attrs =3D devm_kcalloc(dev, num_events,
+					  sizeof(*vendor_event_attrs),
+					  GFP_KERNEL);
+	if (!vendor_event_attrs)
+		return -ENOMEM;
+
+	/*
+	 * Parse vendor events from device tree.
+	 * Format: "event-name:0xNN" where NN is hex event ID
+	 */
+	j =3D 0;
+	for (i =3D 0; i < num_events; i++) {
+		if (of_property_read_string_index(np, "vendor,hpm-events",
+						  i, &event_str))
+			continue;
+
+		event_copy =3D devm_kstrdup(dev, event_str, GFP_KERNEL);
+		if (!event_copy) {
+			dev_warn(dev, "HPM: Failed to copy string for vendor event '%s'\n",
+				 event_str);
+			continue;
+		}
+		colon =3D strchr(event_copy, ':');
+		if (!colon)
+			continue;
+		*colon =3D '\0';
+		if (kstrtou32(colon + 1, 0, &event_id))
+			continue;
+		if (event_id >=3D RISCV_IOMMU_HPMEVENT_MAX)
+			continue;
+
+		sysfs_attr_init(&vendor_event_attrs[j].attr.attr);
+		vendor_event_attrs[j].attr.attr.name =3D event_copy;
+		vendor_event_attrs[j].attr.attr.mode =3D 0444;
+		vendor_event_attrs[j].attr.show =3D riscv_iommu_hpm_event_show;
+		vendor_event_attrs[j].id =3D event_id;
+		attrs[j] =3D &vendor_event_attrs[j].attr.attr;
+		set_bit(event_id, iommu_hpm->supported_events);
+		dev_info(dev, "HPM: Registered vendor event '%s' (0x%x)\n",
+			 attrs[j]->name, event_id);
+		j++;
+	}
+
+	attrs[j] =3D NULL;
+	*vendor_attrs =3D attrs;
+
+	return j;
+}
+
 static void riscv_iommu_hpm_set_standard_events(struct riscv_iommu_hpm *io=
mmu_hpm)
 {
 	/* Cycles counter is always supported */
@@ -757,8 +830,10 @@ static void riscv_iommu_hpm_exit(void)
 int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
 {
 	struct device *dev =3D iommu->dev;
+	struct attribute **vendor_attrs =3D NULL;
+	int num_vendor_events;
 	int irq;
-	int rc;
+	int rc, i;
=20
 	if (!FIELD_GET(RISCV_IOMMU_CAPABILITIES_HPM, iommu->caps)) {
 		dev_dbg(dev, "HPM: Not supported\n");
@@ -781,6 +856,21 @@ int riscv_iommu_add_hpm(struct riscv_iommu_device *iom=
mu)
 					   "riscv_iommu_hpm", -1);
 	if (rc < 0)
 		goto err_module;
+
+	num_vendor_events =3D riscv_iommu_hpm_init_vendor_events(&iommu->hpm,
+							       &vendor_attrs);
+	if (num_vendor_events > 0 && vendor_attrs) {
+		for (i =3D 0; i < num_vendor_events && vendor_attrs[i]; i++) {
+			rc =3D sysfs_add_file_to_group(&iommu->hpm.pmu.dev->kobj,
+						      vendor_attrs[i],
+						      "events");
+			if (rc)
+				dev_warn(dev,
+					 "HPM: Failed to create sysfs for vendor event '%s'\n",
+					 vendor_attrs[i]->name);
+		}
+	}
+
 	return 0;
=20
 err_module:
--=20
2.43.0

This message and any attachment are confidential and may be privileged or o=
therwise protected from disclosure. If you are not an intended recipient of=
 this message, please delete it and any attachment from your system and not=
ify the sender immediately by reply e-mail. Unintended recipients should no=
t use, copy, disclose or take any action based on this message or any infor=
mation contained in this message. Emails cannot be guaranteed to be secure =
or error free as they can be intercepted, amended, lost or destroyed, and y=
ou should take full responsibility for security checking.=20
=20
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=E9=99=84=E4=
=BB=B6=E5=85=B7=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=B9=
=B6=E5=8F=AF=E8=83=BD=E5=8F=97=E5=85=B6=E4=BB=96=E4=BF=9D=E6=8A=A4=E6=88=96=
=E4=B8=8D=E5=85=81=E8=AE=B8=E8=A2=AB=E6=8A=AB=E9=9C=B2=E7=BB=99=E7=AC=AC=E4=
=B8=89=E6=96=B9=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E8=AF=AF=E6=94=B6=E5=88=
=B0=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E6=95=AC=E8=AF=B7=E7=AB=8B=E5=8D=B3=
=E4=BB=A5=E5=9B=9E=E5=A4=8D=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=E6=
=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=8C=E5=B9=
=B6=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=
=E9=99=84=E4=BB=B6=E4=BB=8E=E9=98=81=E4=B8=8B=E7=B3=BB=E7=BB=9F=E4=B8=AD=E4=
=BA=88=E4=BB=A5=E5=88=A0=E9=99=A4=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E5=B9=
=B6=E9=9D=9E=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=86=99=E6=98=8E=E4=B9=8B=E6=94=B6=
=E4=BB=B6=E4=BA=BA=EF=BC=8C=E6=95=AC=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BD=BF=E7=
=94=A8=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=
=AE=E4=BB=B6=E6=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=8C=
=E4=BA=A6=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BE=9D=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E8=80=8C=E9=87=87=E5=8F=
=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=E3=80=82=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E6=97=A0=E6=B3=95=E4=BF=9D=E8=AF=81=E6=98=AF=E4=B8=80=E7=A7=8D=E5=
=AE=89=E5=85=A8=E5=92=8C=E4=B8=8D=E4=BC=9A=E5=87=BA=E7=8E=B0=E4=BB=BB=E4=BD=
=95=E5=B7=AE=E9=94=99=E7=9A=84=E9=80=9A=E4=BF=A1=E6=96=B9=E5=BC=8F=EF=BC=8C=
=E5=8F=AF=E8=83=BD=E4=BC=9A=E8=A2=AB=E6=8B=A6=E6=88=AA=E3=80=81=E4=BF=AE=E6=
=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E6=88=96=E6=8D=9F=E5=9D=8F=EF=BC=8C=E6=94=
=B6=E4=BB=B6=E4=BA=BA=E9=9C=80=E8=87=AA=E8=A1=8C=E8=B4=9F=E8=B4=A3=E5=81=9A=
=E5=A5=BD=E5=AE=89=E5=85=A8=E6=A3=80=E6=9F=A5=E3=80=82
