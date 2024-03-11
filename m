Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF2B18659
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150597; cv=none; b=p+oJS42KKniyfGPX/HFmMCmXmDLnozWZmFSQod8QyLCadsiN9vwaxjfqOGY4FV/m37MMkWLgCNbxeyYbBSZv5GIiwIVmQeT61ymoR2AE1i/JBP3PAJ0opCLPMaTI0brJYhrqOybKsQzptpr9eHF9IGwNwOzORimdn3sOfZonw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150597; c=relaxed/simple;
	bh=AToYTf+vDn2ZCE/0NLRzCVPVI2xnwx7R0rBGKkMz5O8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UVOK/XszRZDbBCFxbNtZMM0P6o2J5PVchtnDSN8cuN7LsjiXnQbN8sm89rxQmlRQ5ya4Fiz+060O++zSIrSEzdNkkV5NYqktYYRziWc/cKEIWVyonz6fhhk+ENewDXKlgVQKT2gwtDinhY8sMkZBP57EzEUV632PY2R/OxkeEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=av81D5/L; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="av81D5/L"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609ea26233dso68100397b3.0
        for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710150594; x=1710755394; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=81noNCiMPxc7RXsxTs6R3a4olVVx7LQELUcM8AsXs8I=;
        b=av81D5/LYqqdPf+RKA/hVsRtc/n8iuNp1ZaMt2WLsTXY3L8g1ZXBJl9y6oA14rc0DT
         HJnn33bXcZezHIxkboB9Yfu0Mba90ku+WTGSRbywV898/woTBTE9JLeQLaED9OOlVarl
         vPFApaxAFw92rHybq0oGQUKCorQo+O0SWdPktiYS0/ujO5uR/Q/IHUmghRRzLBinIT8X
         3CZB9HtFYlMYO55i3/C0D1AnseGTipWohrtNF9wTXUp1ycrXrZil0TN+9TUG0CjZrTQ8
         EyfzbN+sl8RbqSfjQm/fKiQXNFtyNn+tDLFqzHYYRxJIaoMmKWsSvoqe471hi+Ave+Jz
         wkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710150594; x=1710755394;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81noNCiMPxc7RXsxTs6R3a4olVVx7LQELUcM8AsXs8I=;
        b=YoOimWXUsZh9utu02MhLpO7bYc1uIirFP26dTPgji+Qgz0c2OqpVaEgu++A5tw7ljW
         chbJGtjpBAzHc0zcpbrPGBXstAJj/RMQTeV5c+zLKi7ogjCkUwVpCQxITPOAJnXuh0zW
         7bqg84DvIIWPLt/dnTzHkCansyzBSWg4veVnqejnh1sl6dZepmOnSn3PMBTNn9QHfIjO
         xXirP2d7jLcVwf/V1NUkmvleTZ6HMSk/liq185yddr68Kjv+iJhA+RyJPob8nFTJfpaX
         Lmjk9Q7s/m44r1ea9YgOKxnEJ8ve/QrYNQTdksZk+aAGuI8uWjQEtNDKK63/tJg5fa12
         amcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkGovWoMg1y+8+sd3WeCPTH1R5CNI88qxsszHbJitJ6GX854JjPDKlgSbWtylN543THXKbC1KLW0UmNKYr4P5g9CNQX70=
X-Gm-Message-State: AOJu0YwjROQ22zXxo8FGSAvH8cMgsC9J+yIdIHBOSCcXs4n29owRWczB
	a3lxShhrvbwTU+JAjGwnxy00rVNcVWAaHa7UsXxNX92rzetqF98u0T78TjIHz/PoKrfKQUJBCWy
	rDPb0R9H7d3xdvA==
X-Google-Smtp-Source: AGHT+IFYFQpiOp2C90LA0H4wOyWDbp4XswPBvjOI48ZxhaXXUEmFbQzr+aoAdPr6DHMiXATByGHh6HKfyGHsCAM=
X-Received: from howardyen2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:16f7])
 (user=howardyen job=sendgmr) by 2002:a0d:dd04:0:b0:60a:25ce:c165 with SMTP id
 g4-20020a0ddd04000000b0060a25cec165mr1150328ywe.6.1710150594639; Mon, 11 Mar
 2024 02:49:54 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:49:45 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240311094947.3738200-1-howardyen@google.com>
Subject: [PATCH v5 0/2] Add support for multiple coherent memory regions
From: Howard Yen <howardyen@google.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com, 
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com, 
	broonie@kernel.org, james@equiv.tech, james.clark@arm.com, 
	masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	iommu@lists.linux.dev, Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"

In the system I'm working on, there is an always-on subsystem which
includes a small size memory, and several functions need to run and
occupy the memory from the small memory if they need to run on the
always-on subsystem. These functions must allocate the memory from the
small memory region, so that they can get benefit from the always-on
subsystem. So the small memory is split for multiple functions which are
satisfied with their generic use cases. But in specific use cases, like
USB3 devices which support the stream trasnsfer or multiple devices
connect to the host, they required more memory than their pre-allocated
memory region. I tried to implement it in a generic way and propose this
patch to give it the ability to get the memory from the other larger
memory to solve the issue.


Changelog
--------------------------------------------
Changes in v5:
- Fix build break.
- Use of_property_count_u32_elems() instead of
  of_property_count_elems_of_size().

Changes in v4:
- Add the driver where uses the multiple coherent memory regions.

Changes in v3:
- Re-org the members of struct dma_coherent_mem to avoid additional
  pointer arithmetics and the holes inside the structure.
- Use consistent naming of return value.
- Re-write the dev checking statement to be more clear.

Changes in v2:
- Replace the pointer(dma_mem) to a list_head(dma_mems) in the device
  structure and initialize the list_head in device_initialize().
- Modify the required changes in coherent.c.


Howard Yen (2):
  dma-coherent: add support for multi coherent rmems per dev
  usb: host: xhci-plat: add support for multi memory regions

 drivers/base/core.c          |  3 ++
 drivers/usb/host/xhci-plat.c | 19 +++++++-
 include/linux/device.h       |  5 +-
 kernel/dma/coherent.c        | 92 +++++++++++++++++++++++-------------
 4 files changed, 82 insertions(+), 37 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

