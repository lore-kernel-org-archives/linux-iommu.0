Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786623845B7
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130214; cv=pass; b=k7P7bQYbrX33hyWKYOn7WeUSf5VAPtQI7gA22lfl4laoHKnEeZZugmkSVDQMe7vm95jsmQ8V+hYrgAlLjveqzxLmyQXVuch/XQ9BcR8BS5D4oprXiloBS6e+EY1KFYEvA1C2GxxTzPiT1g5592/mY9VXX1uh9mE1//WtvsgOEk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130214; c=relaxed/simple;
	bh=ntjLPEYi5GRPAiZuo7cclkhEyY2tz4aKN8Y6WdSUrUE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QplcNSVOkUDviwcs3LDCZvdASbttMqtV9L9/E4uY3ALe2BoQhpoA7frhbnzb8wXkdb25/FxGqmIUqMwwpozl+expI+wHH0QjP5g1KJLxMtX87b58qSqOyWxngHBt6wQhbSXN1UmrnguM07naCibsBnIJxivmd02th/aUezjklkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTC2mDR2; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTC2mDR2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b150559bso20788175e9.1
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 11:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779130212; cv=none;
        d=google.com; s=arc-20240605;
        b=Z0YxCb3fLGn3NaNnbqV+vZdafy7fAchI3BVtyvUbbhKxzkudQ5bbGz3sbi7uuDEhAt
         WdanUux3V+CDZBZxvdr3kPNvbKzj9HCTFHi1FEDUAHfTbTwa5UzGHZe+pjuSkCv0rLUU
         jirN6aXJeEJkBzuXfML6biu87oCbxOSdtik8mCyOV4aF1C/2tTV5TYc8SzFtCxYkD8v3
         GSdg222bWRgCxW4zR1dRzJNGUkMvH1zpD/tWo8ZjMjv6wDvWhakjuesPCluXZWKPZx7k
         Roa8b6WBmdbbvQCbizNAYpWj9mDkQKW76eMXSz/CbSdoJ1FFPjpN/ciUhlVwylKSTc+O
         8OhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VqNnxkjBMmJhXWFpK+NCwtLhzLfiA5Rwy9PxwlrjgDo=;
        fh=/UNQnTD35aKplFi3gjaOkjGdeDc1gaoJLqiAoMd+Klg=;
        b=KLJsF9uRexPqxxBYOLagt5L7yam8Q0U4p48Wly7/HG5DZkExXpgWGAUxCNOZ2Xqfr0
         qsJ4V/WenCrYPFwXaLZ1V4VWvRuBwCeF8HtnJ4e/Nw0QNX2B8RIRUDVmlz8dOH2iT5Id
         oyON8or1YtH+RVHUQ7j56t1ACMP33rCXKKpCqEDCuMmry8FQoUwMBNU9xNPM5dV1tF1s
         BDwEgso27hRic+Q7ghHuKBsQxza63miL7Am7Y3yk2+nSjbCpF84S4GMdLY/esulv5cCo
         Dpqviu/jeWWAlFBtmk5Xh24KB8MNdY2qx2EK45JsJhPywsw+xmHDNKoJ4wKwYkbrWL3w
         buBw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779130212; x=1779735012; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VqNnxkjBMmJhXWFpK+NCwtLhzLfiA5Rwy9PxwlrjgDo=;
        b=PTC2mDR24Kj/ogG4JyNXjKCIlz71UcZhD1db2WEBdT1X1PgKeN+nSR0IpIgrynnkAP
         Tu0/fn70LiULoZMKIPjrj7iuV/XObqA3MG4htoawrG6WWsy4u/NJHRvldPX+UXxubO5E
         YEsJT7DMWRFvxAGPz8ds3O6diUE28MnoGFG1h/cq1tngGbZInVV+AFZBsz29FVNb2mD1
         j5AdzNKRuKIUl8E7uYoKu8nWTiSTWqnd5kFLf6sKitQx74q0lFCd2MKJ4loIfWH30CET
         sH9GkartMf8RRx+O0HGhbWrQ7Q4UD2QHkkhVtylWfTeW6Uknsgsy2KwH8ztaAbOqzi7s
         aXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779130212; x=1779735012;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqNnxkjBMmJhXWFpK+NCwtLhzLfiA5Rwy9PxwlrjgDo=;
        b=p+lNzhg8VHYB3Ttzg/es9S/4RLNL38O/s+DonHAxk5zcGTPi2fi5XxZsZzZ1V5b7sW
         bsgBZS6xb3sCHkZI4VUBu085lbBqO0AyNhHv4mBuGHmTL8Aic8+RyoQayXeQbltnjUms
         pK6fJe/K+vmChkMGw/T40Nj0oWCMo3daQ6aVG7u6lPfAv2YxfpzlneHU6A5fQz+RbwlT
         PHaAtMl8wZ4OYRpkElB2Lo0xuPQvu3tQ9RxRrmkoNdY4MbqXTHgWdTtL5rWYRIqZTXwv
         sxPhAH8gZD4M2vRRu9tfXzXeT9BUqWFaX1QuNt0134mkb0WXQKgYOgvMTCQR3mAEKO+1
         CTpA==
X-Gm-Message-State: AOJu0YwoioXfrTHxKjJzuSHcRZaSuJ89o7kIJjWTmrm0VS7T7jOfJVnB
	VofFOUzAWAS+gZ7bSK+YwBF2yaHnYFY7Ir4lAIToODjiYNq/fMjJPyam2dc5jJDL6NpJmWEFidu
	bdSTk626kl1b17TrramTCw2Ef/BfUB+mYL7sESAc=
X-Gm-Gg: Acq92OGUPk8Z+8DrxWs71gRqLRQdLbPxg7cyASn2SB04NQrWtiny5j/1HazPszjzfn1
	VvyMh3EJdUF1AukWMPGf3d2AgYi+i6R3HusbyUai0xXk3En9kJjR6VQNftH33dbuZjG3TobA43L
	Y5fhxX8GGUELFun76UJJldEyXOiDUt88wTmv9t+6mhW5Jh8ukON88UykwstP1x68u7QjLaRc/ec
	l9cdZDdQPFz6G+iOyR+jT1j4wxCRJK0XiExG3rKhutq8Kv8cxNuorLM+eVEaL3LdRBj74XocLCr
	vigBPEGw7dncFDrerpo=
X-Received: by 2002:a05:600c:3506:b0:48f:e44c:e058 with SMTP id
 5b1f17b1804b1-48fe60e13e7mr243263145e9.1.1779130211678; Mon, 18 May 2026
 11:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 19 May 2026 02:49:58 +0800
X-Gm-Features: AVHnY4LP4WEjN53zWIvLnqiUH8Ng1-ziqjtJncIzUtEbTdyAtpzVtgYcIetns8s
Message-ID: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
Subject: iommu: iterator used after loop end in resv region insertion?
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, jpb@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all,

While reading drivers/iommu/ I noticed two places that look
like a past the end iterator pattern. I would appreciate it
if you could take a look and let me know whether these are
real issues and whether they are worth fixing.

The first is iommu_insert_resv_region() in drivers/iommu/iommu.c
(linux-7.1-rc1, around line 873):

    list_for_each_entry(iter, regions, list) {
            if (nr->start < iter->start ||
                (nr->start == iter->start && nr->type <= iter->type))
                    break;
    }
    list_add_tail(&nr->list, &iter->list);

The second is viommu_add_resv_mem() in drivers/iommu/virtio-iommu.c
(linux-7.1-rc1, around line 523):

    list_for_each_entry(next, &vdev->resv_regions, list) {
            if (next->start > region->start)
                    break;
    }
    list_add_tail(&region->list, &next->list);

In both cases, when the loop walks all entries without break,
the iterator has gone one step past the last entry. &iter->list
then aliases the list head via container_of offset cancellation,
so the insert lands at the list tail. That is the intended
behaviour, but the access is undefined per C11.

Jakob Koschel cleaned up many such sites in 2022, for example
commits 99d8ae4ec8a (tracing: Remove usage of list iterator
variable after the loop), 2966a9918df (clockevents: Use dedicated
list iterator variable) and dc1acd5c946 (dlm: replace usage of
found with dedicated list iterator variable). These two sites
in drivers/iommu/ were not covered.

A candidate fix would track an explicit insert_before pointer
initialised to the list head and overwritten to &iter->list
only when the loop breaks early. The observable behaviour is
unchanged.

If this is intentional or already known, please disregard.
Otherwise, I am happy to send a [PATCH] or to leave the fix to
you. Thank you for your time, and sorry for the noise if this
is not actually worth fixing or has already been spotted.

Thanks,
Maoyi Xie
https://maoyixie.com/
