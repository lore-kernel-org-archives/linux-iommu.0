Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC0391
	for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585570; cv=none; b=WbR/eBiBowfNZOj6W8qV6FGlZcS+gmlkcXLpr8eyr696QX95YFSTT8FCYJkyEljkA6/3gxApDGv+81O0k4ogziHZ051qM7Nw/GXLVaifoPeD1/fnPUaO6yWG/dSUzxrBDAN0K/btpSXqIw2vxrAZXWy7mx6HWwuqhBekC3nL2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585570; c=relaxed/simple;
	bh=v2ZZeeqqoeqVVBwfwGHzwBc28rv9kX8O4U3pgllvZMU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AayxSewZyGetG6UZVy5wEcAlmHORto6958T8XPEciLSsaAW47+oVfBpXRzoFc2WIZ56CdoF6ys22L6aT45qDuPRs2Q6JbBV8zFojrFAlcIdBC0TFh8ZOC3drxpeF8UWiG8Ox9QYH5iXW5XeMSb63Rsh2nCXyq7jQkOsAwQPBDKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiqb3om+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiqb3om+"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ea568d8216so4311581a91.1
        for <iommu@lists.linux.dev>; Mon, 25 Nov 2024 17:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732585569; x=1733190369; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FeXIRz+voy9oY0ahmpzmVjvKjLMTGNrTBZYjONA26RI=;
        b=aiqb3om+cA5E20+MMGT5lDk5c8n+Jx2X0HCUusE6KuxXtJmJi9E4zwQPVWG8ZAbjHD
         BDmGdu4A9vKm+V0SM6QRzIzlx6ExwVOtn45NwKRI90VuuBOWbercJoqwch8lrX3j8cJH
         yti501sjCVaXby5+r0jgXPxb3Mt01p1fMuCKR/j/Muup4QWh4aBxpod5pS8ORcv2ahb1
         yvOCDFJXUGE+7Vc2Urlvd9+LdUZ7G5mczw/MWp9ZaY8tqhnWPwxd5FeQuOZzHIf7Phy+
         5mT3xTcXht8A66N8ADbSHICft+4G0TM5KBwnduONWlGUVDRB21INwhNYZvb556VGA6o7
         feZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732585569; x=1733190369;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FeXIRz+voy9oY0ahmpzmVjvKjLMTGNrTBZYjONA26RI=;
        b=STXXtDC5r5wY1qAZHYEUWCN/fGFrKaYcFy8BFkZk7IBOlsj6FqOAjWVDH2nRYNlRxn
         +FS0q1qR4LWCSnQSvrFwyC5SB0EzvP0FneeyTzbjUMf0v6+h4Jmp4zfhhKyyrWT3NNNU
         bxogyfUcifCUVCPLnAoHf5yLGPeOwmGjLfTcrNsyuPVDZjTcYwXnuef0EdX6NMgojzKW
         gRNT6gkmvNQXsPUUHLkjs7tAo627XlXqkSnO6nTY5xNFSjZbGq4LEZm4y1tq7tA9eeqy
         59wDcKqFBPidr4E5uKvnwMitnGAaw3OoZOKw0+vinrhpbBSYvOYuDv16Cw59hib9jGh/
         CKwQ==
X-Gm-Message-State: AOJu0Ywe0VvedpFL6SPP2PpHVmwvHGWtOLz2KjAka5wo48l6PrWqwGFO
	ke9SQFIk7jR7amMyDNNs+pNY62BUvK0Ygog4ip+e5Xiq8zZVuLVreZGJK8xzaAC9MJURF42mQKX
	DKQ+gIys83/ffDBMHpd3zprywkww=
X-Gm-Gg: ASbGncvY9+70ptqqCzWxiNYfXwtCV6voR+IGpt5dpEF1wAzI2/3NjIkmcQ70Y1ldMYq
	sboLhXHzO95iiuTGg91K/xOMBIqJJKQ==
X-Google-Smtp-Source: AGHT+IG8EzAshG5okGmZG0whAC5I9ZPfewmJR9vy3whIx2vYnEC0yhECfkL0T9p39NwZgLHb4d1+IfK3/+2wKMMPEMA=
X-Received: by 2002:a17:90b:4c8c:b0:2ea:7755:a108 with SMTP id
 98e67ed59e1d1-2eb0e12c9admr18324964a91.4.1732585568782; Mon, 25 Nov 2024
 17:46:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 26 Nov 2024 01:45:57 +0000
Message-ID: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.13
To: pr-tracker-bot@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> The pull request you sent on Fri, 22 Nov 2024 09:17:47 +0100:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.13
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/ceba6f6f33f29ab838b23a567621b847e527d085

It seems to have a minor merge resolution artefact: iommu_present() now
has a header declaration with no definition.

Thanks,
             Dmitry
