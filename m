Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED44432ED30
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925923; cv=none; b=FHD33Zvelx+GzKtDUR576DRWiu9FM8jErKcjxRqfaOrkN2wVnGJv7rMEvYzK1SqCGifdzyatve2yiyUyoLeqGEP1QEgi+NN908TnxOsaDe+CRZxJ6twUhpTjoUSHUDm/pdg9h4p7LvZVvbvHuVum/HwvPrA26JppqGdxJvNSUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925923; c=relaxed/simple;
	bh=f5TD10qIBuF5n1eeJ9VIsupQTqy4/YXIBveHRRzBLNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG6RZ2iDOUNBo5FRrZ/vF1ClT+aVjjqakY04BwySYlNl+6fwDFC9leUsmKhq7LslVBzz/k3Xh6/qh+ImDlWRvhMAtr4vHuqvIQfBwrlkLDccaqoY9gB9BMB4ehK8SNhLMyOAgSK4rg6aKb+5mIZFG2hNdjivQ4ciGUas/HVnG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZHEZ59c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZHEZ59c"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so11125e9.1
        for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 14:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765925920; x=1766530720; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+K9oHXy9CoE2Iutxvsb9f32gwPILUiKga23gHX+m8Es=;
        b=VZHEZ59cOUevxleYyz6azWkR6EGtDxR6r6H0w1Psd6JKdR7ocQnv1LSeBPLDN2/+1l
         dLSUR/HpofIkVFcORdkD0aReLHSe4QCTNLk3bnFt1VnOgsEgYRAQBxJh/z8tQG2FNKfO
         jirE9c/jX1DeB6KubQkSgpaceiHSBHV58oSMTHHoUEeQ1o3EYzrEFTkCzgQbabuXdI1q
         Yqo2OFTRtgakt5lN6vd1HPkAQewXuf5CEX0RlWbNoK5qH3qzCzLY7Veg1JvxUDE+TH+X
         /yyIaPwxbq5MaGEsSr1MRZvpfE6rJikL43QcgjdBhLmccAmBml0yBHKodopYdLbynB+2
         0DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765925920; x=1766530720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+K9oHXy9CoE2Iutxvsb9f32gwPILUiKga23gHX+m8Es=;
        b=wtCd2Ka4qV9SqGxkqyBNBb5f51oPHJ4/wLSx82uhR6NjNAlKkK6jlcAHwPfaNQL+9x
         b/2Z7OsO8aJ+UQKWqO4eLPdT+kuOC9b4dPa6O5AbubDP3lR07xXgWSREvttDx5qSh25T
         ybUvL1jpJh23MQRDhBseUfAn1pSBnfsrMw1+TJmOTgzQmRSBESpTnXSL6ZTH2rdLMZFl
         7jv9FMjcU06RRIkM3Ot3unsTf/cwFYf5GmS9nenk1FhLfUAp+pFz0i0/peunIzM+lTvm
         xf9V1rohQRqF47gnaRIerKefbxVZ9PzBpgYsdxtBFYXa2cvS+7aRPHHW3minc4ryTv/u
         xHpg==
X-Forwarded-Encrypted: i=1; AJvYcCX/sotcrlYcrG9UQe54WT7ORVyA1Jk1ZwHiXq47fQi9vzJnpIfIlqwG/bemAUqkwK59AwHgLg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy28phoRRBedhJDrGyb7/4kR8+hJgdJk3UwFzHIb1auwUTNbSRr
	C6Pi9stkz71+bN1zFp4RhmQS6oBJXWJs6lPIcCrUQq/RM7I1pxjRaVFIut5AW6kHTw==
X-Gm-Gg: AY/fxX7AI0BtQrIO9nMr0asSbse7NiwiiKJ1Hc90ZZw4wq5Tfg6cR5AF9DEok5OxFSA
	jRNBywowGzlpENTwbXR03dq00Vf8bxj0tgDKbX+2XmMXFXnMQjrazsSRX96s2fEfHNdsN06jRJ6
	DqbkWlwph+Aq4TzarakBBs1Ic3e9rNnUhPBVl3+PW0dSc1/Coc44NUw5LaQoR1D6OopRUQilgpf
	2IF75BCIKVNCaHJRYmPedWFF8LRlHSk5BvQS5qPyUSgaI871+i2t3LStqT0sAJNp4eUHqqjo1nL
	1VIG2WfTpe8roBgh1c+2Etij0sglzoIzanq1toaOgaZdX9AggMOgvGCgGkTXGGbliIQOdlcfcx8
	qfErkIiFaV5ze27uiaInNRVCBX6uCeoee271ob3eT8xhiiDtHUJ2fmdhJkMRJR371oW0MQuJ+3h
	k/XpXudZvhyGvTL5qBkN5k2A6GM7h7Cs9zXSWOMVpMKu4i1a4gvMGr
X-Google-Smtp-Source: AGHT+IFlMVBkDaS1E2qi3AffURSPog2nfcOnVrpcf8Ei/2t/IInwUKpWIeZ4ineTv2meyteT01GDwQ==
X-Received: by 2002:a05:600c:58c6:b0:477:b358:c0cc with SMTP id 5b1f17b1804b1-47bdd2be429mr49955e9.17.1765925919932;
        Tue, 16 Dec 2025 14:58:39 -0800 (PST)
Received: from google.com (170.226.195.35.bc.googleusercontent.com. [35.195.226.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc1edd26sm10841175e9.13.2025.12.16.14.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:58:38 -0800 (PST)
Date: Tue, 16 Dec 2025 22:58:33 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v3 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <aUHkGCEeu7L5uCMR@google.com>
References: <cover.1765334526.git.nicolinc@nvidia.com>
 <cc0d4ab571e2e789ee1cddfa035379dc54f0601b.1765334526.git.nicolinc@nvidia.com>
 <aT87A1ur4htPjM5T@google.com>
 <20251216000952.GA6079@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251216000952.GA6079@nvidia.com>

On Mon, Dec 15, 2025 at 08:09:52PM -0400, Jason Gunthorpe wrote:
> On Sun, Dec 14, 2025 at 10:32:35PM +0000, Mostafa Saleh wrote:
> > >   * Figure out if we can do a hitless update of entry to become target. Returns a
> > >   * bit mask where 1 indicates that qword needs to be set disruptively.
> > > @@ -1094,13 +1100,22 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
> > >  {
> > >  	__le64 target_used[NUM_ENTRY_QWORDS] = {};
> > >  	__le64 cur_used[NUM_ENTRY_QWORDS] = {};
> > > +	__le64 ignored[NUM_ENTRY_QWORDS] = {};
> > 
> > I think we can avoid extra stack allocation for another STE, if we make
> > the function update cur_used directly, but no strong opinion.
> 
> It does more than just mask cur_used, it also adjusts ignored:
> 
> > > +		/*
> > > +		 * Ignored is only used for bits that are used by both entries,
> > > +		 * otherwise it is sequenced according to the unused entry.
> > > +		 */
> > > +		ignored[i] &= target_used[i] & cur_used[i];
> 
> Which also explains this:

I haven't tested that, but I was thinking about (applies on top of the patches)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 72ba41591fdb..9981eefcf0da 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1083,7 +1083,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);

 VISIBLE_IF_KUNIT
-void arm_smmu_get_ste_ignored(__le64 *ignored_bits)
+void arm_smmu_get_ste_ignored(__le64 *used)
 {
 	/*
 	 * MEV does not meaningfully impact the operation of the HW, it only
@@ -1093,17 +1093,14 @@ void arm_smmu_get_ste_ignored(__le64 *ignored_bits)
 	 *
 	 *  Note: Software must expect, and be able to deal with, coalesced
 	 *  fault records even when MEV == 0.
-	 */
-	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
-
-	/*
+	 *
 	 * EATS is used to reject and control the ATS behavior of the device. If
 	 * we are changing it away from 0 then we already trust the device to
 	 * use ATS properly and we have sequenced the device's ATS enable in PCI
 	 * config space to prevent it from issuing ATS while we are changing
 	 * EATS.
 	 */
-	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
+	used[1] &= ~cpu_to_le64(STRTAB_STE_1_EATS | STRTAB_STE_1_MEV);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_ignored);

@@ -1119,22 +1116,15 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 {
 	__le64 target_used[NUM_ENTRY_QWORDS] = {};
 	__le64 cur_used[NUM_ENTRY_QWORDS] = {};
-	__le64 ignored[NUM_ENTRY_QWORDS] = {};
 	u8 used_qword_diff = 0;
 	unsigned int i;

 	writer->ops->get_used(entry, cur_used);
 	writer->ops->get_used(target, target_used);
-	if (writer->ops->get_ignored)
-		writer->ops->get_ignored(ignored);
+	if (writer->ops->filter_ignored)
+		writer->ops->filter_ignored(cur_used);

 	for (i = 0; i != NUM_ENTRY_QWORDS; i++) {
-		/*
-		 * Ignored is only used for bits that are used by both entries,
-		 * otherwise it is sequenced according to the unused entry.
-		 */
-		ignored[i] &= target_used[i] & cur_used[i];
-
 		/*
 		 * Check that masks are up to date, the make functions are not
 		 * allowed to set a bit to 1 if the used function doesn't say it
@@ -1142,8 +1132,6 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 		 */
 		WARN_ON_ONCE(target[i] & ~target_used[i]);

-		/* Bits can change because they are not currently being used */
-		cur_used[i] &= ~ignored[i];
 		unused_update[i] = (entry[i] & cur_used[i]) |
 				   (target[i] & ~cur_used[i]);
 		/*
@@ -1575,7 +1563,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
 	.sync = arm_smmu_ste_writer_sync_entry,
 	.get_used = arm_smmu_get_ste_used,
-	.get_ignored = arm_smmu_get_ste_ignored,
+	.filter_ignored = arm_smmu_get_ste_ignored,
 };

 static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d5f0e5407b9f..97b995974049 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -900,7 +900,7 @@ struct arm_smmu_entry_writer {

 struct arm_smmu_entry_writer_ops {
 	void (*get_used)(const __le64 *entry, __le64 *used);
-	void (*get_ignored)(__le64 *ignored_bits);
+	void (*filter_ignored)(__le64 *used);
 	void (*sync)(struct arm_smmu_entry_writer *writer);
 };


And we only clear the bits from cur_used, there is no need to for the
other mask ignored (ignored[i] &= target_used[i] & cur_used[i])
- If an ignored bit is not in cur_used it will not impact
  "cur_used[i] &= ~ignored[i]" as it must be already zero
- If an ignored bit is not in target_used, it doesn't really matter,
  we can ignore it anyway, as it is safe to do so.

Anyway, I am not fixated on that though, extra 64B on the stack is not that bad.

> 
> > I have some mixed feelings about this, having get_used(), then get_ignored()
> > with the same bits set seems confusing to me, specially the get_ignored()
> > loops back to update cur_used, which is set from get_used()
> 
> The same bits are set because of the above - we need to know what the
> actual used bits are to decide if we need to rely on the ignored rule
> to do the update.
>  
> > My initial though was just to remove this bit from get_used() + some changes
> > to checks setting bits that are not used would be enough, and the semantics
> > of get_used() can be something as:
> > “Return bits used by the updated translation regime that MUST be observed
> > atomically” and in that case we can ignore things as MEV as it doesn’t
> > impact the translation.
> 
> Aside from the above this would cause problems with the validation
> assertions, so it is not a great idea.

Yes, that's why I didn't like this, it had to hack the validation logic.

Thanks,
Mostafa

> 
> > However, this approach makes it a bit explicit which bits are ignored, if we
> > keep this logic, I think changing the name of get_ignored() might help, to
> > something as "get_allowed_break()" or "get_update_safe()"?
> 
> update_safe sounds good to me
> 
> Jason
