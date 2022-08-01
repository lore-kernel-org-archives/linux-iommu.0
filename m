Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F87F
	for <iommu@lists.linux.dev>; Mon,  1 Aug 2022 19:22:54 +0000 (UTC)
Received: by mail-pj1-f73.google.com with SMTP id r13-20020a17090a454d00b001f04dfc6195so6565343pjm.2
        for <iommu@lists.linux.dev>; Mon, 01 Aug 2022 12:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=xzKHytVvjAao+2ektxnj6IJTTJHXIKpBW60SHOyYd8A=;
        b=IbUODt/ipvk5XzL0d6Ll8FYMNlWCOw2TGe+4/1TXn/4J72Z4NnLKUwp+3vykOq4Cph
         v+9PduVmkV7gHlDU7BzBz8nUxBX135N3Xp0dYQqZ0ntyjhUFZXfT92RMXTAxoEbrJtPW
         oqLUI9k6eLsoyGQA3UF+6GCF7NifNqF8svyfvSd5k7TKUVFyeJFJ6sbxEw2GksNoqlmq
         oY1FmdrhjTzTb56UdhiiHMGGWaXUBg505x3mEhR310sZ2zFW8Q66BgahHVDHvOpqsbIO
         NK+wfQdRhogu7xSDRv3pJzTvUufZKNmtcNUYQ9cq3Y1Vnngl/v/SNGUa6MbirS8o7bL7
         KTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=xzKHytVvjAao+2ektxnj6IJTTJHXIKpBW60SHOyYd8A=;
        b=UBH2etSkS9QtjFw9JzyfByciTGpqkaF9YJqT8RmgK6CRxwLiTrtJJIJaKGxjpevA43
         /gQuhaLNc+I01bYjEfM5ADmJUL9MIKuaxutvMWoTnUNPIDZ84XSbiRGvrkP9rvaOBYri
         SpZGifPKlODe93Q6cKT28cSVdsf0PRzRF1mx+//Qw1Qe/kJWCyUmcaygLchg20dlt/4B
         svHqi+1Yj50CJ1EIaG8WRCwTAnHBe7k3kvoDuKoJWtGL6crwnOVVvoVb7m04o/qMJFnL
         7p4NuVwVavR+MzqF8nNM8GSiKlKaYtAPSD7xBusFHWfgJ7CDjA9iMcTkgoeXSKFBUW0e
         OmBA==
X-Gm-Message-State: ACgBeo0oR3bImCaGyDDx1lewbGmeCvNXfSxOhXpureYFlHR5+3SHulmg
	pk8YQZ5klqLB4wWpYIMiLsJ+MOl5+8mnxEc=
X-Google-Smtp-Source: AA6agR6OCI1ewtlVf1n57DMxiF0gydUpv0yJmM/Nnd+N5kO6NjiUbnV0sr7xqRctjNbC+/sO8RfjIlWoqlDHUMs=
X-Received: from jsperbeck8.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:301f])
 (user=jsperbeck job=sendgmr) by 2002:a05:6a00:c86:b0:52c:e9ef:c790 with SMTP
 id a6-20020a056a000c8600b0052ce9efc790mr14411075pfv.50.1659381773627; Mon, 01
 Aug 2022 12:22:53 -0700 (PDT)
Date: Mon,  1 Aug 2022 19:22:29 +0000
Message-Id: <20220801192229.3358786-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH] iommu/amd: use full 64-bit value in build_completion_wait()
From: John Sperbeck <jsperbeck@google.com>
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Logan Odell <loganodell@google.com>, iommu@lists.linux.dev, 
	John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"

We started using a 64 bit completion value.  Unfortunately, we only
stored the low 32-bits, so a very large completion value would never
be matched in iommu_completion_wait().

Fixes: c69d89aff393 ("iommu/amd: Use 4K page for completion wait write-back semaphore")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 840831d5d2ad..a0924144bac8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -874,7 +874,8 @@ static void build_completion_wait(struct iommu_cmd *cmd,
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->data[0] = lower_32_bits(paddr) | CMD_COMPL_WAIT_STORE_MASK;
 	cmd->data[1] = upper_32_bits(paddr);
-	cmd->data[2] = data;
+	cmd->data[2] = lower_32_bits(data);
+	cmd->data[3] = upper_32_bits(data);
 	CMD_SET_TYPE(cmd, CMD_COMPL_WAIT);
 }
 
-- 
2.37.1.455.g008518b4e5-goog

