Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80147480342
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581184; cv=none; b=BI6p75ZOIazCRwG1gQpO/iA4BD3FgofFc9G4knXynqbffeUStIURMjc7Xbn/LsjN7HLqYTtEyoyXjh8bKZYZrbmdC4VhDZ8zSAc6qe70PgFrPxEJhp2YKkDzh/esEojho+LY4h+y1XqLw1VEHWTNelxKKrp/185i44vJW2unpI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581184; c=relaxed/simple;
	bh=KmQHc3v3JVs4EnW94C19ZfoNPOYoCnubmp9LMyZqsGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJq0H3OlBE61SB5B4bXAGdKWX9HZ2jGNs3h69T86JYJOBsM7hEhL8lJZGjJ7limfgSEnhq1plzvOZLAnC06N+0/h77+sk+tUGJd7UjoPbUjx1jObjxB2MMDvaNygXNNDQg1zil1YEs69jrYlWTBbZmszOczt0ul25thKYKros1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjByhwyL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjByhwyL"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso573351f8f.0
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581181; x=1781185981; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OH9hQQFNIkDpasnao4boz8/RAiMZ7MOKPgy4BqZR+6c=;
        b=AjByhwyLw58B8vlw6a36Pxsj43wa+t/glDIQqLSV6iaXDXnc3KFsRUXZMGnSdifATH
         K/3rhub/VrMwQCDtnsUI0bWEqwEgBgECxV8pzh+jmnJ9tTVSB0sRKwg1ZI/zOmKW0qLG
         f/sbEMCwcHMUwHaulpGyteVdoi3h8K+ABrCoMjThlm4F5RV5ibvDYT0UlpXDFLLhAlCB
         kc0M1fEpbLs0DsEV/ewfskXDGQnqv7ykRy57BdcYRgXHpkGN9o2b0vJ5Wc35JEe7z1FT
         mt0RuF1+ikudNLHd6hGNXI9VQN9fA53P7WjTH2V/kFzCnjKE4rSr34TGlCZtOOUBbckl
         k46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581181; x=1781185981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OH9hQQFNIkDpasnao4boz8/RAiMZ7MOKPgy4BqZR+6c=;
        b=JTLLODWIX3uErGeAv4p3hMtMVDQzEQFe0gCHzRUc8eTfFAHS0YY+fY7+D/dmfiOVn2
         HUn7bEWrCNfVMYpOS+0v/pOIf9gN1+a8/19PKGhw2JzQo9M/+n7ts9CoghT0ZpoqAllw
         d28QdTPV4s1/2czIWsibIPEWrbRAq7yezKnNGiZSfHBl2DIpu/efsrDDQbXY/tnUIeYC
         K6s0Sa6q0bpua53pspw1BGj4RV3sHrVi6pOM9WHqaJY6joUEmz3MXdB5R53/7JYPbiFr
         802160qwuZOo0j6rah9q+fU5QLcHubcrFiRqp0qeLMLLbDdLNwwkf8oHvIhkS6AUtOV/
         0tVQ==
X-Forwarded-Encrypted: i=1; AFNElJ80hpADBYCTse25i+naZ3CL+rjK1qXl0+Qy5IjyO6jEywY9njYZxNp9xDcJOj2LcKCyWKvq9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjDACqgXPgYKs5/D/4VAdKTBpx034yIFDMgGG/7u7OJ7CBm2fM
	FdxLK84n7tLrFCAFYipPnzkvWDwM2qjmDhEhiidpm3SQivYOnTqtxsrj
X-Gm-Gg: Acq92OEkzrYJJlMgPjHBo5YU81RfTue3lQ54hr+O+47UuJZDHfmO+RmCgbf2rsk/mx8
	HiAaMl7vx3c5art1gHk0pKR3L4yfZaLdGJjltEZatb8WKnNarLWOJlu/b/oAvjX9KHD+GPNcN58
	wRLqvp9nin4lCXNXEfXJcsn0hAzd6pLqzD3Y/2MmEuARtSryjqBy+UyF1wTg46yi7ZjLpp+yHpl
	S4DvCU5zJOHMbLrucEBWxuALDNLc+MCbIJmH7YEVL0FYCuGNurAGbyQvYAXJKPydiynwafSYPo+
	d1xIAu5UyaHdZKjtAoHE64T9hXP9Nspgfr6YQdnDHy/Un17iF6HLvB0VZjxQwxBz8lOdVCLkjxO
	/qDY/F7V6j9Xeecyscrf8MKOgBwzwaOChpuTpjNqUI2rY7OwmJhxPqaU9d0sI92DIruh3orpP3U
	lJ3bkEeoqdntb/wN9TlnL6e0VL3fsTwU1D00kjDuH7DpNVB/6/bFwrQgwBvznfOXU=
X-Received: by 2002:adf:eed2:0:b0:452:6aaf:76cb with SMTP id ffacd0b85a97d-4602178b717mr9418813f8f.1.1780581180807;
        Thu, 04 Jun 2026 06:53:00 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:53:00 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 4/9] accel: rocket: Reset the NPU before detaching the IOMMU on timeout
Date: Thu,  4 Jun 2026 13:52:50 +0000
Message-Id: <20260604135255.62682-5-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a job timeout the NPU AXI master can be left wedged with
outstanding transactions. rocket_reset() detached the IOMMU group
before resetting the hardware, so iommu_detach_group() ->
__iommu_group_set_core_domain() asked the rk_iommu to stall and wait
for the in-flight transactions to drain. They never did, the stall
request timed out (-ETIMEDOUT) and the IOMMU core WARNed:

  WARNING: drivers/iommu/iommu.c:157 __iommu_group_set_core_domain
    iommu_detach_group
    rocket_reset
    rocket_job_timedout

Assert the core reset first: it quiesces the AXI master so the
following IOMMU detach completes cleanly. Move the detach after
rocket_core_reset() and out of the job_lock (it does not touch
in_flight_job).

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833f..e25234261536b 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -364,14 +364,20 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 		if (core->in_flight_job)
 			pm_runtime_put_noidle(core->dev);
 
-		iommu_detach_group(NULL, core->iommu_group);
-
 		core->in_flight_job = NULL;
 	}
 
-	/* Proceed with reset now. */
+	/*
+	 * Reset the NPU hardware before detaching the IOMMU. A timed-out job
+	 * leaves the NPU AXI master wedged; detaching the IOMMU then issues a
+	 * stall request that never drains and times out (warning in the IOMMU
+	 * core). Asserting the core reset first quiesces the master so the
+	 * detach completes cleanly.
+	 */
 	rocket_core_reset(core);
 
+	iommu_detach_group(NULL, core->iommu_group);
+
 	/* NPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&core->reset.pending, 0);
 
-- 
2.39.5

