Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E022E3A543F
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634432; cv=none; b=drBerSqsbEisAcsW8fetRVOxNuWDHowAPfKfskq6u3n6GNpApFnyFvrRVR5oFgpeu83uRK4ZhJChnKjFdB2ganIHodWx8zzrRdzUk8U+MTgI0J/7U8v9t5c7E2/Fa2G4uwdAJdwXDwVImN+O2LzbtHcThE0S9jQLgQKsk5kxC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634432; c=relaxed/simple;
	bh=4IbK2AkELhYHNt+kY7TsOF+nTpzv9kfiFGq+yMByoyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MYbX6Kb552BAiZeVgE5xx5OuHbQ4gGygYprn7ecDfsBbgFROec5PbciMmOxseAb47VpwG1CDQWRY23VAHOCT9t43stCHTlPJ0LtiyQVZllXcyLaF5WLlRyVqzDFKvRzkC7SWQHR2OPJqdFl8N+baS+TpFZRz7K8QSGw/2RjzqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=El114B6W; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="El114B6W"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-66a3c95958fso1406491a12.2
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634429; x=1778239229; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvQ7rT8sfpUuWMPN37mpWwK5CZ/GStRVkhZPxjRKMSU=;
        b=El114B6WHQSZrVNKRMW9hno1y5qRGiruWB35RIEvmD8edufwqO02HNK4HV8QTPuJEP
         bGb6I4gysY8LwgYdcxwHp3is8dQGKa279QZdkiLhLa+COgj1ObZWpCHP6VO5sRaovEOQ
         LkUyWgw4ZzFKIID80ASATkBWQv0tJbZEiaUTcCpHyCTNce7SFfMI6PrkclsHcsY7dGXb
         K9uTncnKvp0EPQ3X0O/OmV80jiLVZS48vUFKh9gQbOwBGyDOUF/QW7XCT+ONQstKUMuP
         A/EiCeE98MJb2eLG2MvSt6flPzNIfpQYg3IHPOLbqTqm4wt1aZnS2k7oisHxD5xjGGH/
         /0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634429; x=1778239229;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OvQ7rT8sfpUuWMPN37mpWwK5CZ/GStRVkhZPxjRKMSU=;
        b=W5sEw67BJ38WcdQ/yhSGgxZsqFiecXwRH7TQ9ZZi6seeGYAL5A1UTLo2nch27bds42
         6STeyKvREL+KeYp4kFinLaQ8rN0lhmkC4+xVDJTMF4lipL/JKVU9Dz8mdgV+9Dmj2TOg
         +3ip2yw6T3rykCbj216BJhWeLxu7QAW1FfU7SdksKB/l4IDjG3gqnsfrOVkC1nG8QPQi
         j214828+TvqO0oVN3HkhMmkltiq5l5Sehtzas16zwqwuu9j9QKi7zYq5APc9kVv7mthZ
         qGU81wp7bXe43VqMzJM5DtREG50ihcr6wzYl696YXxD7mqsCcLSQMou02P/wxiJPkgy/
         E/uQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wNKhKWuc8ctyRUQniuFk4Tj+H0nMNxChMkGCwJKLwqF20Wv83hFReq+xsjlhg1uDsEb29Rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQN0J3fP4+PerbB5D7DHj6to0FqkJnDU8KoDeE++gjRxGNNOoY
	umHagQjKKt47VnqNE8sMFTqi2n/kB4XrScCauJkkzTZ6SjFOmEI8tfT/TjF88PMcTquUlysLRks
	NVot3GpkGz1SYEA==
X-Received: from edbeo10.prod.google.com ([2002:a05:6402:530a:b0:66f:bef2:d9de])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1588:b0:670:8b38:5717 with SMTP id 4fb4d7f45d1cf-67b5d84910cmr3588586a12.24.1777634428940;
 Fri, 01 May 2026 04:20:28 -0700 (PDT)
Date: Fri,  1 May 2026 11:19:23 +0000
In-Reply-To: <20260501111928.259252-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260501111928.259252-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501111928.259252-22-smostafa@google.com>
Subject: [PATCH v6 21/25] iommu/arm-smmu-v3-kvm: Emulate GBPA
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org, jgg@ziepe.ca, 
	mark.rutland@arm.com, qperret@google.com, tabba@google.com, 
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The last bit of emulation is GBPA. it must be always set to ABORT,
as when the SMMU is disabled it=E2=80=99s not allowed for the host to bypas=
s
the SMMU.

That's is done by setting the GBPA to ABORT at init time, and host
writes are always ignored and host reads always return ABORT.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iom=
mu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index e258690384f4..1ed5ccce7849 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -126,6 +126,22 @@ static int smmu_unshare_pages(phys_addr_t addr, size_t=
 size)
 	return 0;
 }
=20
+static int smmu_abort_gbpa(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int ret;
+	u32 reg;
+
+	ret =3D smmu_wait(false,
+			(readl_relaxed(smmu->base + ARM_SMMU_GBPA) & GBPA_UPDATE) =3D=3D 0);
+	if (ret)
+		return ret;
+
+	reg =3D readl_relaxed(smmu->base + ARM_SMMU_GBPA);
+	writel_relaxed(GBPA_UPDATE | GBPA_ABORT | reg, smmu->base + ARM_SMMU_GBPA=
);
+	return smmu_wait(false,
+			 (readl_relaxed(smmu->base + ARM_SMMU_GBPA) & GBPA_UPDATE) =3D=3D 0);
+}
+
 static bool smmu_cmdq_has_space(struct arm_smmu_queue *cmdq, u32 n)
 {
 	struct arm_smmu_ll_queue *llq =3D &cmdq->llq;
@@ -468,6 +484,10 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_dev=
ice *smmu)
 	if (ret)
 		goto out_ret;
=20
+	ret =3D smmu_abort_gbpa(smmu);
+	if (ret)
+		goto out_ret;
+
 	return 0;
=20
 out_ret:
@@ -756,10 +776,16 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_d=
evice *smmu,
 			val =3D smmu->host_ste_cfg;
 			goto out_update_regs;
 		}
-	/* Passthrough the register access for bisectiblity, handled later */
 	case ARM_SMMU_GBPA:
-		mask =3D read_write;
-		break;
+		if (len !=3D sizeof(u32))
+			break;
+
+		/* Ignore write, always read to abort. */
+		if (!is_write) {
+			val =3D GBPA_ABORT;
+			goto out_update_regs;
+		}
+		goto out_ret;
 	case ARM_SMMU_CR0:
 		if (len !=3D sizeof(u32))
 			break;
--=20
2.54.0.545.g6539524ca2-goog

