Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3E7C433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 18:14:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60ABB60F23
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 18:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60ABB60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E32B402C6;
	Mon, 11 Oct 2021 18:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uTyqRFw7sISI; Mon, 11 Oct 2021 18:14:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BA2D940120;
	Mon, 11 Oct 2021 18:14:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DDBBC0011;
	Mon, 11 Oct 2021 18:14:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D534C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 18:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DD8080D94
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 18:14:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0rEYZmvWNIDY for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 18:14:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D23F80D4A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 18:14:14 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 r43-20020a05683044ab00b0054716b40005so22752308otv.4
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=so5v8xcVc8H+6uvaMOS818TeIXcZqDh/c1PHeEhQkb0=;
 b=dJS2ociZaxImnyy/ctc1JFg0DxR9n+uzK2WvywdKtbLnpKPJ+o6XQ5Vh/f7E2cRZEC
 /LXvgT39HtTQRqr+UxRHCJbfeAsrSCcmGNnu8EXR9tRAl3ppEvWeLIkqHSG2FiqWYkPZ
 Sy4HRmErsTzwR9S0HnxF6U+dIBtVCGsPWWyQrk8v90VV0Zw0YlpcPvO18Pi3AzB2fPDW
 SG71nGm9fSvU+4NWtI5cWNkBywG90U2UVgLlHF0gPUjgLal+ff+XjaqaeUMYz1wAjyJY
 TmTc5bAyh43f0fkN6KJJvkaEYzdMeDcj1wQzX6MdHcTSct7SK439M0Nbn1R8LDzEX1PO
 08mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=so5v8xcVc8H+6uvaMOS818TeIXcZqDh/c1PHeEhQkb0=;
 b=2TVuJBp9ovmD7/bwsFXqSwiHQYAOY1hx+xmneyVG8UhR8ySXAh6PLPMQ+zAB+ZNqJj
 tBc0CujQ93Uc2WHmW5Ll1ax894Z6w3CeSW1bXa92+8uPf0aqsmpzKPdyej2FTpOlYOXB
 UvisqpBYYSugnmS6tjV/qECjpZ+vrVMwz/azvr42WxgnNKPOD1Ta7y7d0TWY7u5lxK1Z
 JhOgAsv+BC62ELzcIjJ5L/1Q7HZsh+khKV9IgN8Vp4uoFESYF84PdDv0lWleCOQRFBPo
 /mnAtFPYO87IbcgelAPcv6qlTl3BnHbChcMchoA0o7/m3KUa68/14V+NcDowVd7B49BN
 0/0A==
X-Gm-Message-State: AOAM532SX8ZzZXM7eExJwV1whgWWtRD/L6O1fX8Y3NBojhHsEdTiRrkW
 ETOy/o5Qqwu+UpEKAHmVBOaYysQ35Iaou8ziEus=
X-Google-Smtp-Source: ABdhPJxo7Lkg+QlgZlHkpUhc9g80AxNDDCis6WeGaKpbzXyEpPer0n7rrlVxTEMErsvMZrye4BUylFm5IgjzpQASsDw=
X-Received: by 2002:a05:6830:2816:: with SMTP id
 w22mr21954487otu.351.1633976053471; 
 Mon, 11 Oct 2021 11:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211002124012.18186-1-ajaygargnsit@gmail.com>
 <b9afdade-b121-cc9e-ce85-6e4ff3724ed9@linux.intel.com>
 <CAHP4M8Us753hAeoXL7E-4d29rD9+FzUwAqU6gKNmgd8G0CaQQw@mail.gmail.com>
 <20211004163146.6b34936b.alex.williamson@redhat.com>
 <CAHP4M8UeGRSqHBV+wDPZ=TMYzio0wYzHPzq2Y+JCY0uzZgBkmA@mail.gmail.com>
 <CAHP4M8UD-k76cg0JmeZAwaWh1deSP82RCE=VC1zHQEYQmX6N9A@mail.gmail.com>
 <CAHP4M8VPem7xEtx3vQPm3bzCQif7JZFiXgiUGZVErTt5vhOF8A@mail.gmail.com>
 <20211011085247.7f887b12.alex.williamson@redhat.com>
In-Reply-To: <20211011085247.7f887b12.alex.williamson@redhat.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Mon, 11 Oct 2021 23:43:29 +0530
Message-ID: <CAHP4M8UmnBH58H3qqba1p3kyEiPUk9xTp063yJr8RFduUNjgbg@mail.gmail.com>
Subject: Re: [PATCH] iommu: intel: remove flooding of non-error logs, when
 new-DMA-PTE is the same as old-DMA-PTE.
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org
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

Thanks Alex for your time.

I think I may have found the issue. Right now, when doing a
dma-unmapping, we do a "soft-unmapping" only, as the pte-values
themselves are not cleared in the unlinked pagetable-frame.

I have made the (simple) changes, and things are looking good as of
now (almost an hour now).
However, this time I will give it a day ;)

If there is not a single-flooding observed in the next 24 hours, I
would float the v2 patch for review.


Thanks again for your time and patience.


Thanks and Regards,
Ajay


>
> Even this QEMU explanation doesn't make a lot of sense, vfio tracks
> userspace mappings and will return an -EEXIST error for duplicate or
> overlapping IOVA entries.  We expect to have an entirely empty IOMMU
> domain when a device is assigned, but it seems the only way userspace
> can trigger duplicate PTEs would be if mappings already exist, or we
> have a bug somewhere.
>
> If the most recent instance is purely on bare metal, then it seems the
> host itself has conflicting mappings.  I can only speculate with the
> limited data presented, but I'm suspicious there's something happening
> with RMRRs here (but that should also entirely preclude assignment).
> dmesg, lspci -vvv, and VM configuration would be useful.  Thanks,
>
> Alex
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
