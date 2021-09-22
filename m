Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D06C4332F
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 22:26:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D58611CA
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 22:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09D58611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C629C83F8E;
	Wed, 22 Sep 2021 22:26:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6cjH5tepJr0j; Wed, 22 Sep 2021 22:26:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A7D6E83FF1;
	Wed, 22 Sep 2021 22:26:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80AC5C0011;
	Wed, 22 Sep 2021 22:26:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24490C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 058614068F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:26:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lz-VPmLY4_30 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 22:26:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A98940630
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:26:04 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 me5-20020a17090b17c500b0019af76b7bb4so5555000pjb.2
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 15:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d1Se0bIv+AZshTnNE9EXhZho8yO0a4lB3cun5QpGO0Q=;
 b=AMOdyqDsI3sfVqMy3qg8nuHbTL6w3lfG8gnPtR1OtuZBPCgWgVij+0H6Cv1w4e3fPr
 Ni/kOR6QjMBnux+XtxdvKzMxBWetD3eI+SRnpqUTd6YKwW2kJU9qIzJ4k84+akfKdu89
 UcUIoX0aZSlmUQxt6F83PCTKXnj8c+M3ykpcRD3SKbLSUBAQo+gLz1b3TdgMGPel3Gic
 qymi1EeqRnYzoFhU4iHTbipF9p2QT6scT4VQLY463NFpI/2HJa6Vs9ZZlRzUkAZ+wwzl
 l3+/+1XBXvsVb5+0tMm2xp7/MhjJB43pJUW+D+AaTNkFKn78WzlpJnzFzQ9wax+EIdUi
 y0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d1Se0bIv+AZshTnNE9EXhZho8yO0a4lB3cun5QpGO0Q=;
 b=eIYBZ19ipp/YZtZK2JzpKK2wBUJ2l+AJNTciaYQKkxKyAbqDNfT5k8dZr3Kqq5UTJK
 kou29FVAEd0eR20cReoNxz04dGDI960adELoS8ZXVV6CA6yiAYFIfDsj5DFy9nDnf8wf
 n3TyeKZIQhsAVY9wmmsZte8KEPOa0ZB+E14LBVVwC43CR+gQKUP/6u0x4aUp+VOmVkGR
 IPSX3HS5i+FL63f+dcMI5dm1Ffo4pXzdPyWhm0QLudBXQSUV2w0wV1IX+fedIvYHe5si
 8DGBOrSmGeYOAkivjNMYvPDn6pST0EcnuQRSnHGvod4Axfa/QcqZBEL7MwoRYEzhSN11
 xjwA==
X-Gm-Message-State: AOAM533y1cYccif0iYytO6QkDeTwIn4/4nqOEREpsZSotSQIzX+nSpmZ
 wkArwzvCOuo7Rxqyronm68U=
X-Google-Smtp-Source: ABdhPJwX2anKJfJb319odBXPr+/Q/RO097FlrwVWHxAunhfrjJfsuUIcGPPvyO4DfF50oI+6k0xD6g==
X-Received: by 2002:a17:903:1d0:b0:13d:aaea:a35d with SMTP id
 e16-20020a17090301d000b0013daaeaa35dmr1282793plh.78.1632349563520; 
 Wed, 22 Sep 2021 15:26:03 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 fy11sm319278pjb.32.2021.09.22.15.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Sep 2021 15:26:02 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 0/3] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Wed, 22 Sep 2021 15:30:20 -0700
Message-Id: <20210922223029.495772-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Yangtao Li <tiny.windzz@gmail.com>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 Douglas Anderson <dianders@chromium.org>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 Dave Airlie <airlied@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 linux-arm-msm@vger.kernel.org, Sharat Masetty <smasetty@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 freedreno@lists.freedesktop.org
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

From: Rob Clark <robdclark@chromium.org>

This series extends io-pgtable-arm with a method to retrieve the page
table entries traversed in the process of address translation, and then
beefs up drm/msm gpu devcore dump to include this (and additional info)
in the devcore dump.

The motivation is tracking down an obscure iova fault triggered crash on
the address of the IB1 cmdstream.  This is one of the few places where
the GPU address written into the cmdstream is soley under control of the
kernel mode driver, so I don't think it can be a userspace bug.  The
logged cmdstream from the devcore's I've looked at look correct, and the
TTBR0 read back from arm-smmu agrees with the kernel emitted cmdstream.
Unfortunately it happens infrequently enough (something like once per
1000hrs of usage, from what I can tell from our telemetry) that actually
reproducing it with an instrumented debug kernel is not an option.  So
further spiffying out the devcore dumps and hoping we can spot a clue is
the plan I'm shooting for.

See https://gitlab.freedesktop.org/drm/msm/-/issues/8 for more info on
the issue I'm trying to debug.

Rob Clark (3):
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Show all smmu info for iova fault devcore dumps
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 35 +++++++++++++++++-----
 drivers/gpu/drm/msm/msm_gpu.c           | 10 +++++++
 drivers/gpu/drm/msm/msm_gpu.h           | 10 ++++++-
 drivers/gpu/drm/msm/msm_iommu.c         | 17 +++++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  2 ++
 drivers/iommu/io-pgtable-arm.c          | 40 ++++++++++++++++++++-----
 include/linux/io-pgtable.h              |  9 ++++++
 8 files changed, 107 insertions(+), 18 deletions(-)

-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
