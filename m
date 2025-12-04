Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED33491C7
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866959; cv=none; b=Cm5/4x3zxq9KM1UH64qQvgbW6YXivR59RAH7Mkex3j/koIwzDMeHYQVBC9M3fQYMCCp2SzsHvvyZYS1nXNU+ESi6KueMiHUqafuzDvVeEipTGVlMhAySCFZOVrKWrw6lqUmnu7WN2PK61kTPHVJVJLeAsu333uA3olusR6LmM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866959; c=relaxed/simple;
	bh=pNTWl/c3lerxkSw0rL3hvq6mNtAB1BGv+e0Xp9fi6gU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DR/9nTsIxuGlGlvUY4vCOfNYUvdmnPM/s0aBKIZUx3yad1QcRQFaaoWNuwWdUgv5nTh0OphVfTI3ZNyH6CZ0z36v5MYOBtffKF+zM2hP+GTbGeb93ME52nmA7dGHZcXusb1pOI5a50RFi2lcNDWruT9nSEHLFNTCO0Asiv5cJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BIeST+DU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BIeST+DU"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b79e7112398so210569566b.3
        for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764866954; x=1765471754; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYdlDUMxTJfLAfjf8j4z/ZZ18s/2EWT4Q/SIqp5BkQg=;
        b=BIeST+DUW4/8DoXVkHWZOu4+lZ8miMR7O0sqw6KbiEdeTJqE4YLNiGkP3QtVMLnaXF
         FODSm7XdgPkwMBcknsRl6t8bh5d80lgB5Odgyo9TCz2r9TE8uOKa5ByNa1mfavpvMst/
         rZx6+dGKIdOaZnw1mg56OcJi7r8xFJrjZ+pJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764866954; x=1765471754;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYdlDUMxTJfLAfjf8j4z/ZZ18s/2EWT4Q/SIqp5BkQg=;
        b=WmySEEhdQt7PB4DlPs9bw/aTO5n6AdTeoUyz7y1HzirXGfbNQI0KqtYi9svKh3He8n
         LZ3STs2PwlDZWP5z7nRrShuYrbkK4eMjs+N+0oZZmMpMauzmUknlEAa24UU+P2I7HmiQ
         5u9ZuaLf5U7ISZ5/I3XfeRLb+q6YBcRbiZmcwCORo9RexA0vJenJwVf+N0BGuF1XBEhn
         XDTsu4+qRAMyasrttTb22gQ696pUCzJ11N7+NHmIDkG4lqr8KasvFxzvJQijZiRzELx8
         0Ms43L8jhQds1NSmAa6uRY7Ex9zAFbm8g163tvQAq41x9XIMm1NEfkRxgHOG8xIAFwxC
         o6qA==
X-Gm-Message-State: AOJu0YyuLus/K5dhKbbeyBzZbj4DuSDscJ4ZPmk9SjDVtD6+98C+9ela
	8kLPJwU5Z7qWqLDZv3zzv6QyH6xpJ61rjuSx0JU7H+tjnBMAOvRqf8PoCdZAdqMPfvARM99qFcL
	edKStsA==
X-Gm-Gg: ASbGncuL8l76MqTjekE4GQPR455BNO4g18/yM3F8ErdevVD8JiQ2C3ttCce3dCT4oM/
	YP3pWhH+qKD2a/VptiuoWDYW90cbMt1URDWrNyW8p1cBRLFRlB7y+14UWW7aEU+eSjeZnNznDyh
	QaVHcXj5yFm+XVQI3C0wzvb+RDI3g741E4v/37XC1OXTdhAoH5KtorYBkF8e8MS1Rh0b47iKE6N
	W+K2X86qActO9Bs081COHtSGV2kj7RdThkxoIionzNGt+117XFJtDT6BHcd+v+s2JP37+jmGfgp
	MOCQUZ3WlDgBrVhHkgKUONxKpp780upVgUszilLIPa1zZYG54Jd9x10g9ZPN3TtlU6ddFdX8lvK
	+F+yzduLGlwsHJw1aHI2ElDJ7S6UJAfNdqKVOF0cjXmD6tFkeHbjK3zAnQPZRb3g6Ik6gXsGX3s
	VWwA+/CCinsPwuNxoiNA==
X-Google-Smtp-Source: AGHT+IHL3Lk4ovmtUaC18/bNreinF4rQWWNt2Ce9nIYmH/BV4lkFDDnS5spnyobtUb9L29gVvFju9g==
X-Received: by 2002:a17:906:f850:b0:b79:f753:6910 with SMTP id a640c23a62f3a-b79f7537d59mr158746566b.40.1764866954111;
        Thu, 04 Dec 2025 08:49:14 -0800 (PST)
Received: from google.com ([2a00:79e0:a:200:1264:2fc0:4e66:3ac])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b368dcebsm1741211a12.21.2025.12.04.08.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:49:13 -0800 (PST)
Date: Thu, 4 Dec 2025 17:49:05 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: iommu@lists.linux.dev
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: [Intel IOMMU] Question about memory ordering in context/PASID entry
 updates
Message-ID: <aTG7gc7I5wExai3S@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When updating a context or PASID entry, we'd better make sure we set the
present bit after setting up other bits, not before, right? And indeed,
for example, in domain_context_mapping_one() we are doing it in the
following order:

	context_clear_entry(context);
	<set other bits>
	context_set_present(context);

But it doesn't look like we have any compiler barriers to actually
ensure this order? (And in case of context entries, there is even no
WRITE_ONCE or anything like that.)

So, are we just hoping that the compiler will not reorder it?

What am I missing?
