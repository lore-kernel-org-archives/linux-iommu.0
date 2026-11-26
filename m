Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795683337;
	b=r0Ud4WVKIso3I21U3FeIS2FfNmQK5lOu4ukKdx9Cgjhmq0cnv0er9J8+5W1H7RAcWlwj
	 33hZVhMFOgPTu3l3UCJym7IJFkhiwNNwuupghevpaYkhzDW/IuvSmL4dSfiB0x7eSmTjo
	 2/fWxJEjMwuOe00/wB4jLpLRZ2YMfsfcrCXEWkCQ3yUHiSJE93cqMrW8b2S37gBVrTYyo
	 9uoIxoeGZ7AHP459px4Yjck9/UryVJKiS+FiAWv2AMJunZNtFhgu9zUuiYrPoPOZd969Z
	 W++IRoLP5o1dGIlOPz6+EXmwBsvAGkjwfRm2GAA2U6SI7T+Xjc/dpL/uowiVSPKPD+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=QKThXZIRAMEkOiH8X0ve/DDQDh2imYfE9WZ4cHyq7O4=;
	b=dZzjKg5mTCTBheS1Gf896LUAzjaPFWXSQWvqlpeWmJd+nWgPgCp4arjboL4hJD9OAzJY
	 tLQyrsITWcxCf55uYw27CO3YVryhBAN4sn92vP4fMkFwxycl+oyfpqcZPYfQpZLS89Tq5
	 i2z3ZBW34afrZiCejQhirIUnMoGvFYAVGgfDaOch4WSqqKZlVKlYqlXDRQGfAcdu2a9eB
	 jz69DC2JLGHjd53gv6jhSnX70Nm30IO3arRvKDgg1wY34bLEO8XufpnIO51ncJxFvEt6U
	 8DuYa8W9bTWQMbFwv8iTzTxbIVKss+/B0D+SJ+U8BkoJNzCK8GYsX4gvypMsLFQcY/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLSp8Ny8;
	arc=fail smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDD606A684
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 08:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8EDD606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLSp8Ny8
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c00b0866b0so401166e87.0
        for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 00:55:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795683335; cv=none;
        d=google.com; s=arc-20260327;
        b=Szvm1ehVHL55gAuaNG8ZgzGuuRMG6QYh8p1bMK3BKmsxnrwNrCP4u0ZMXhskhWn8QR
         SoYwEvYcM4v0QUGBHXlOa3bi63QVOkN2ct7BKp5/Wq4FaI8mrA4vMscPPlHZA0lLsBNb
         fDMlrIM54O9ElEY5scKxTTTcHiXZQcxJgbS1TL37MMDYdgK2skVr30otQTlM31OqtWyq
         yyrXIhgdAbeCdFIueMAcnxKWc4aJQ3Mau1roTvr7lrq2ZCDZ93YTNfYnK580HgcORdSr
         lnyiY8hbDTjh8zZ1nB4F8tbhAkJhQnwIi8SV2x5wn95wyO2zPXbhIrOlFycs+4b3+5Wo
         M+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QKThXZIRAMEkOiH8X0ve/DDQDh2imYfE9WZ4cHyq7O4=;
        fh=+JW4HUwqtbZs6q0MoH14tPpTjsJ3gBwk+80zCy0NX0E=;
        b=jxNUy/3jUOk2hQj22R9w9g1jW4CTTJ9W6gWQR+AYBqtZ6Z/VCxJoT5Pm4LaCnuCHYR
         N9V4bgiqExjYm8c6TLlobug1sBvICU7FCcDb7qCWEcGVeFBTJ5+mwJweW8yrbG+4p49q
         hPd8TnCICtqhd4W+w/pSvE/egwoNYetiSxmJKMafpFHufFNoQm/CP2LSUNqafD6cR4e4
         zy4M38tvTlYA2dLRpPQ9IRE2lp8aYwtqbJhHkBS1OuPgnyUpwXBpT6TBCXimkMZ1i1DE
         mu4nHQGEgcBEb/ecCiYscAmNfHdr7sIrzNLrEvyLIz2U76cKM/0Jbbh1NK+YYxyR5bWV
         fEwg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795683335; x=1796288135; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKThXZIRAMEkOiH8X0ve/DDQDh2imYfE9WZ4cHyq7O4=;
        b=RLSp8Ny8KRfDFDap+jLS5yzps0Hez38UIE0GYlGQdLBpDJYD4qzRle1Xf6WtnuRvgP
         2beO4kMaeukyHD+AFUaNRYY2SXklprZ3m/vzg2zAqCqNrlnLYlgeglYCvfRrkzsS68Ql
         /GmVmlklGTU9jqn/ICIvW9ZinbMBVmvx3ftDc5aRW+wgc03wq65zyrstFjSymvRr1u5b
         Mu40o67j6EPqGi+qCOb/NTkQZGBQ1+atjprgr8lgzPuHCWVaO/o4LWECOqxi/N1/yIiS
         qqEhB/N5Q8V8FdqTMYA6AArlMQRZElcP5Z+vh5TsmucpgEQcQT6XnCTEEDwzLqRS8sfk
         tjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795683335; x=1796288135;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QKThXZIRAMEkOiH8X0ve/DDQDh2imYfE9WZ4cHyq7O4=;
        b=rhWOKl8M/spXqOUT+zu9WEMsN6cmtk2vqVmarIqHZ6KYV5Xk4ixfxlfLd3bo+0IN+S
         QSaiec37VjogBVBqo1lOjexQ/9/IlN3iC9xmdyppIKxksXgqnY9ArJ0lsdEhnQNJATRY
         qZW8ZikufION1+P4I1KS148QBhREbgXMz+/lHp16oZbwkjdPuZo8YxLh5HPut0XV19c+
         ECrh+6zaBX+uIJZZxK509mXQ1BcCD9kjSX4s0UsXS/FoDSZW+V9cWcs+N2ghS5B/jisK
         Dm9pfvvsudPFg8jr8Bi7Mbs30PZ6MHTCq9/yKDg7j0NLn8jH4/MZVbnP+yCAXSF2g00L
         XqqA==
X-Forwarded-Encrypted: i=1; AL+hErEE31rK7EDZ57w/3ue1+fa84eGmUohAqBvhLL0VBg0eT4bzIR+MkzKbupEph3WBqTa4ru0vkg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+5fBTLezIXSr8rMRYuo7UHQeir/LTjWjL6/6mB0witRgxnSVN+
	g+clP/Y2m9zdmgwO348b8jc8ZhxXX9axztExlG1a9jokGmr8gzFRB5aZXYpWbfDew8xE68LC3IT
	TMSJkOdD4QgjO7fX52adszsHu8PbN7gQ=
X-Gm-Gg: AZFdTZdgBRCGz+2fc8AVDTjvrPK/FcAu1Hmm8mqpsmdssp0PqXAlI/ecJU/+EXIRW58
	A/110+zRlE1G7ekk+tjcOyR4lrgJcbZx+jFSNEHYWX6tjUnU/RmHfY5LAI8XmF1NFJdNOUrdGol
	+EqiG44nxeaWdlhTUiuudr9gVmSmhsIL51Gftk2FKy4Ffxtt5lfouXsGpNb2XuLuqLpyGWl8/Fy
	wDWVduuT9R0rpftE2BfiHDX7HGbec8Orm3lQXpcubqQzPhkPGsiDlAHAYB59sj2Cwfgt1hK26r4
	yjydOVp+XxXXDjO6ZUcu2MjT7KbNdAT9WzBLR5XfCKJm2mpsLjJHS+EivffXS6W7w7iWpPoxZsn
	YpDMg6k+RRYlzIManIittmPN6Uf2M9/sZIO/30/5YuabDw/WD/wMc9PKvlEhIKITNbAW9YWA=
X-Received: by 2002:a05:6512:1151:b0:5c0:62:7fc3 with SMTP id
 2adb3069b0e04-5c1bc7ceb5fmr8223250e87.5.1795683334857; Thu, 26 Nov 2026
 00:55:34 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
 <20261113-mmu600-php-v1-1-231196049a3b@gmail.com> <20261123-quirky-scallop-of-beauty-c662b7@quoll>
In-Reply-To: <20261123-quirky-scallop-of-beauty-c662b7@quoll>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 26 Nov 2026 00:55:22 -0800
X-Gm-Features: Aa3M54pFlibDAmDC24529Pztyl31CflHnU5Me60OGDKTLA2a_3s21NJ2pQ1ALv8
Message-ID: <CAEy9hNX-TiThoXZ9+Q7j=bB7PpNBr7Wjz8_sH7C081HXka4xHA@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: net: rockchip-dwmac: Allow iommus
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wu <david.wu@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-ide@vger.kernel.org, Pranjal Shrivastava <praan@google.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Shawn Lin <shawn.lin@rock-chips.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Sorry, I missed the report. v2 allows iommus only on the RK3588
compatibles and drops the nested ifs in 3/9. It follows once the
arm-smmu-v3 clocks/resets binding it needs is settled.
