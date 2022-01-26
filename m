Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2EEC2BA4C
	for <iommu@archiver.kernel.org>; Wed, 26 Jan 2022 11:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C17B1401DA;
	Wed, 26 Jan 2022 11:54:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02CY6U2iOkVE; Wed, 26 Jan 2022 11:54:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A7D4440209;
	Wed, 26 Jan 2022 11:54:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77DF4C0031;
	Wed, 26 Jan 2022 11:54:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE753C002D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 11:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E97E340950
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 11:54:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G30pIQd_ms0t for <iommu@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 11:54:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7A2440949
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 11:54:08 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id d187so1126612pfa.10
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 03:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=kaYqw2i/tud2QtGYAWleZSZ9J1D//dGFD3AtM+yU3og=;
 b=cOdf94Lzw+Uq4Gg/y1YcF1UdWoGOQG4I0hDtooFx2s7YdD5+wgrUfdpWuqGTf04n25
 gRGLTTiScyvwNY1h2eZtoPYiQcerIGq6THH1YPd0n0ffQfxwb8fK1IRiaVOEU6XotQB4
 H9sgSoPuiuLfkodG/0KwUisBzSE/ypDxlVEiRtOzbHXln1yIcIN43JYpoqmRgRT9jwPn
 tP+o7utiOMkI6x1H0oruL8cbA0hHX90mk45XGSS3DAQeL40cl/ExjKLA/UlkVnWEGZ2p
 awwRKuLIuEltaup0TGJsuHUUeVXfAYlK6pltxuu3q8UYTFq0DnG+iQT/0c6O5Y7t9tW4
 b+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=kaYqw2i/tud2QtGYAWleZSZ9J1D//dGFD3AtM+yU3og=;
 b=nNiPUsawlIiXwFbK46hKtBNc5qaeTgecM36/OBf9LuYNqocBVu84f7W1gg16dZs9PV
 KgQ3+1RrsiFwRfIWyHi3+sEzb6sdkkXPchAkNJlMZJ16zDAluHcbi5Qh7r6oI6RwelAe
 ZM4fR3l6rpvGy59UIi+xXbk5wbki7DHfqg0sifjF+XiJPHYO3zM16ZKo/6GFFS4dnzqj
 t2ZOzpXFS8DwlH6KzH+bTl0sDFpc5KAWZWUJI4mfgg91sems8wDY2q09xhfbPtrqHsn3
 JK/6AhgPIvsA8QkmnV9xXGWFrtN9I4hZ7fjS7IxA6ez14bhTxgDXeJv11Xvc6WOVZ3Kg
 gZWg==
X-Gm-Message-State: AOAM531JbUyQ53tcIisA+8IW2ci4BC9kSagFGpMhYm7Mv0Xi+2mIj4Jr
 fr3cswWGzbM67FSap+jabj/Q3f7lMnBzyQ==
X-Google-Smtp-Source: ABdhPJxUV4Mp/3bHxZgmvJhucCsib13Mg0qGH6srPxA1dJJL00/YHgrnSe1ZZtb1zC8q0vJFuvFI+Q==
X-Received: by 2002:a63:5910:: with SMTP id n16mr1718303pgb.415.1643198048232; 
 Wed, 26 Jan 2022 03:54:08 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal
 (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
 by smtp.gmail.com with ESMTPSA id w19sm2116076pfu.47.2022.01.26.03.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jan 2022 03:54:07 -0800 (PST)
Date: Wed, 26 Jan 2022 11:54:04 +0000
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [RFC][DISCUSSION] dma-mapping: allocating noncoherent buffer without
 mapping
Message-ID: <YfE2XMSmFtDudXYT@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Last month we discussed drivers that uses kmalloc(GFP_DMA) for 
noncoherent mapping should be converted to use DMA API [1]. Simple
grep with GFP_DMA shows that many of drivers are mistakenly
using GFP_DMA flag.

So our purpose was to make DMA API choose right zone depending on
device's dma mask. Baoquan and I are trying to make drivers to
use dma_alloc_noncoherent() when allocating the buffer.

But it's not simple for some of drivers; there is a gap between
dma_alloc_noncoherent() and the previous convention (allocating buffer
from buddy or slab allocator and mapping it when needed.)

For example, some drivers allocate buffer and reuse it. it just maps
and unmaps whenever needed. And some drivers does not even maps the
buffer. (some drivers that does not use DMA API)

So I think we need to implement a version of dma_alloc_noncoherent()
that does not map the buffer.

I think implementing a helper that internally calls
__dma_direct_alloc_pages() will be okay.

As I'm not expert in this area, I want to hear
others' opinions.

[1] https://lkml.org/lkml/2021/12/13/1121

Thanks,
Hyeonggon.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
