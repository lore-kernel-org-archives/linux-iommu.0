Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE42DF156
	for <iommu@lists.linux.dev>; Sat, 24 Jan 2026 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769260954; cv=none; b=CyZmCnNMVsOJqrsW/pf3EcWYus7J8kkG9zMlv/j9Q1P16erHePDoiW9NGbyP+OIRJPoCnkLyoi4QxlJkSJN5avB8n3YIf6gJ4KFCxWD2l2nDYYrIddtkcdnVvUJIdhEvJQ3LKuTNwHRLBJDrJSUCIutdlTdiRrwT+7dd9vT61NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769260954; c=relaxed/simple;
	bh=9//JtA8OaIoxFYYw+s/Q840t0V+d7ji1F95QuPcOs5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoWVyxZ0SnqUKtmbv4+pLJV+CPeGoW85gW3RppzehJoUzYGBd/zdbkCehY2xP+3L2jsfSC7Qwxv4Nl6Hf+1j2ie4slHzqKQ4SDQrf0nduaLv6bIb+XYRltGZgqZNxhU3/NT7ZRvQWUQxaypbE10Thf4tkRccfe/bLzkEgeogGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiCwNWSm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiCwNWSm"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81f47610542so1640749b3a.0
        for <iommu@lists.linux.dev>; Sat, 24 Jan 2026 05:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769260952; x=1769865752; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3028cks4iFVE48ghMmr5PkNA71fWKwd8FwoMoFawpzU=;
        b=WiCwNWSmOL8j/4RHnMaLlEC8ZBYuAGbYMltwSFpTPUAioleUOf8362Lsz1+6fqhRuv
         g2dZri/8EBF13CkcYCoRcsntG8cwMQ9+qZ8cDH+gD0x/Kf3sen5sZznnlO0QUUoU6Fi3
         uHOk74HptgkxXQj7GcqsrugvuDe/4VyqY11LRxHTY1WL4vZPdjaclZiueR1CfYtQCHFs
         lRmbEnPpTHv7Yc3pZtzAJ4TYRQIWeOsb87VGtokzUnSM9NONo2u/EDLJZqu5g8hojWPa
         ARyfPNJwrf1oUwmlg0oR8XNDozw7tnCOXNBkQIC2SxUn7OezfkIy0E+9sav4Rxn4T/4g
         LruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769260952; x=1769865752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3028cks4iFVE48ghMmr5PkNA71fWKwd8FwoMoFawpzU=;
        b=qRp7K1T/xgyMVbDVUD+DXyg/+mOwqfZQ1z0Rn27wKxtfsIiiu3KOgkfGZ6PKEmwT11
         GIqlb4gElKNsFSXCSnS5Mn2BA5MUtQUrM5OfZ13+xXKvk6AXjWbY79bYhDEm/u8L7M+F
         XsrIW4CYe6UJjoL27D/7JqHEk/mws06hzvRXYgA6QZkFm2vJfrXrz9+woZiFahmiPdmr
         B8LIlT5RIaqBg4Cm9z4vvAfDmqIwGIp7VL23nGjUcbD5Cz4DXrGBuxKmWrAbv6ZwGt5u
         z/poSmLsmweae9qmpQkhGm0nnRWYZ20OdSBe8NM6IlzfD94J7x/dWXMc/YYfHu/ijmVv
         1+KA==
X-Gm-Message-State: AOJu0YzkTFkQJm/6CxyoJFf/pB1C9zVjFBhedyZSU1pnZAXucea4IfUI
	GAdKhqFrs4kuSr3AhKpYDCWp0wAVIcbAoZXjvJ0hCS/olXsdSKNwNdXi
X-Gm-Gg: AZuq6aIC/Z37GFr3XwcDs1M7Lg+bbMblFYG0Cxo3A9AAh42iwAWRs4RpQT2Sm7+36i/
	h455iFmKNqyUKmnC55J84VsRntHbIkoGcghuqsOpex/3ehBK6lIbqbTqu18RyuMqYFoHdBANl2A
	81qvLPFqkRW6ljyqZh13iJWOH3C4PnHtr4+JG6EdiLt7Fdv2/zEzSxSKpbGaENyvqHuo6nXPNoF
	HYcAcrCdmshAdyuZQMpCsgGSFgH++zv9oSzP+Ww7vflsWcdmvU0pf8eK50XG/W7xM72Z0TPSoU6
	DIS/sccf6/Od2Ey/rbV4C4ALqFPfxQFomlDHnY3oSNiNWfpV8fZvVr/HjiJx46WDUthSr1PE5Ih
	Wj3yVSVcalOQCuwJC5W24iOEYkFSdkJKj2jvifP61kmOTEKc5Y+eo0cmG5Yw5MpVHa4mTgxlQ9A
	bAhaB12smOxG4CMtJ2Gx/uFo6awVtketWXmJkIcOAIsUmqvyhDT+w9gvbv+uA+pm80nwI=
X-Received: by 2002:a05:6a00:4290:b0:823:64e:9e52 with SMTP id d2e1a72fcca58-823215d8a54mr3500384b3a.21.1769260951741;
        Sat, 24 Jan 2026 05:22:31 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:fc92:597c:e074:9e0e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231877005dsm4839572b3a.68.2026.01.24.05.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 05:22:30 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+df28076a30d726933015@syzkaller.appspotmail.com
Subject: [PATCH] iommufd: Initialize batch->kind in batch_clear()
Date: Sat, 24 Jan 2026 18:52:14 +0530
Message-ID: <20260124132214.624041-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


KMSAN reported an uninitialized value when batch_add_pfn_num() reads
batch->kind. This occurs because batch_clear() does not initialize
the kind field, leaving it with garbage data when a struct pfn_batch
is declared on the stack.

When batch_add_pfn_num() checks "if (batch->kind != kind)", it reads
this uninitialized value, triggering KMSAN warnings.

Initialize batch->kind to zero in batch_clear() to ensure the field
always starts in a known state.

Reported-by: syzbot+df28076a30d726933015@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=df28076a30d726933015
Fixes: f394576eb11db ("iommufd: PFN handling for iopt_pages")
Tested-by: syzbot+df28076a30d726933015@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index dbe51ecb9a20..f606148920fa 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -289,6 +289,7 @@ static void batch_clear(struct pfn_batch *batch)
 	batch->end = 0;
 	batch->pfns[0] = 0;
 	batch->npfns[0] = 0;
+	batch->kind = 0;
 }
 
 /*
-- 
2.43.0

