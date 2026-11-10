Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346656;
	b=vmXH2D69xyxagQxy+rZMI7SdWQv+8iJhfF8t/jfPLJdvkXMReI4EzQMAYm5fbqGnvRKc
	 85utUYCT9B20CzITg9b/tE75X1FQznimAYoMh6R/+973IdlUBlc1SRpwGdvvd/bIJ55gC
	 I8fNNGYQnwf9Ry5HIZOj/MO4CglkCzKFOiqk9zF1SqQxGFZvSsdrkEa0aw2XDHWLWK3CF
	 nd0RlP77yfb19LPlt2K3WszDSLXUmMbvbgdbvaY7+jRLqJYlsM5yN4hFYGpR7gzBc92yL
	 nwhdURZoJu2gQqLNE//dq3bLj7liU9/IIuKYoT7UeloUUX1uDKIYtCFHc7C0Vpwqecg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346656;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=DAgmNXTfpbXfKa6S7OGUo9aQXVJ3R8eY0yHFnv+eejs=;
	b=qy0J97XgO6Dc/V2kz9wvw4mjXiExtIINbnFDxoZkt8/vaM+JVvsT6y3H0LoGyQGv/v1g
	 MHJiL7t3diHaPXezsDV47RrIGaC7pFk87esB9fh0dH19wJM8RNbNXkrMoStqIHv7DSXU5
	 xKYxBJ/woIbDyFMiRg1CJv8IVcEvW6+2Z8i209jNT9IfP7VifK6EuOI47P0Upr44bPe2M
	 yN19zz+s4dzz+DHVoZvQlYWUPcOirduHxSk4NZXMhI0dwfDM4yq9qpf1QarDQXexhTE8z
	 +xHyekHzW9k6OmCOGogzTiR9jazQSNImFQp7WUnCMhDXWzewCCvoO6wlneehIpySVGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=Np4tTxxF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rDDd1bWY;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AF606A335
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 21:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 331AF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=Np4tTxxF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rDDd1bWY
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9D9DD7A0043
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 16:37:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 10 Nov 2026 16:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794346653;
	 x=1794433053; bh=DAgmNXTfpbXfKa6S7OGUo9aQXVJ3R8eY0yHFnv+eejs=; b=
	Np4tTxxFWuLcr8wZ1/V97Lkgp78gyQdflixwCbplordLy4g3Sl6iPZd082zgpm/r
	adxj5dqEINktssCt6Pl6qzSx7EcZ1qfnl85TJxnmG6hEYPOYFKUlgZQEi5QidLhW
	vuv1jJUWYDCltB0xWp/Vi22B0coyQqVcCi4kgYpMFNSa/vVTQ4+WpEN8npVHOAVi
	816QAkuzmL4sW+5K+hg/0RbLXV4XtxdF5M4xLx4WHkHoxi/1Oh2YAMpZeH+bHIA6
	o0GPnYAYNpDOo+0vD8jJ/Mx+qIqG0kUALo6zaAcQHGqdLT0XEPxEPY3Pd2hMeVy+
	3wXruhPDLl/MxvRjSOjF7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794346653; x=
	1794433053; bh=DAgmNXTfpbXfKa6S7OGUo9aQXVJ3R8eY0yHFnv+eejs=; b=r
	DDd1bWYx/N97P7j+l04Ce04kDKN6ZcL31dCqj10/XKe5FLE89jCFBc2v28VoLJBM
	3j8L27n3iyB2Zn/Fh1n1FxQf4ajkbfxsXtFVn1E/6orgSuXSO2FI5oHPUrazoitW
	Fs+d/+Ah8NY6oXcXO7BtAi6Z14/ziG/G4Aq7HV4TKNfkt4eqi/M/7DaqEELflp9I
	he4e7MRRCy1yIBnSdXbs/F6I6jckaWBsnJznbvIAczx3XUp78yuLKC4JcnKS6BUm
	7a3CTDoWlDyJsA0d0xLwJly2cYdj75X+bhjY2Tys8vQF841rtymjIvR5atsVbhLx
	CtjXsIl9QWCpn8/l+pt/w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794346653; d=fastmail.com;
	mf=PGp1YW5sdUBmYXN0bWFpbC5jb20+;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm3:rsa-sha256:Kigrfhre79zoXteHBoL0/T7ncjLq2dbCYqN6tyNQM3NGHub
	kIBPrw8p2if6YGlH3cCT1EwR3LBB/MHBN4xQjFSRWzqmZKGlm5V6bMk9Y0/gGz9c
	wVO66q8wSNqXC3M5qKA6GHJzoSBW50rFD5wAegaE1h69wRsHkZFHx7jcaM1vrmZg
	7kmfOSNiu0MLeTdzITDMDd+uCeHoaWucklU7PC7JhQFqM6tH6gI5Viu+ERU/IRbj
	MDRQfka6Sp99/q2lNZAht0bzmbTOrxJDb71rOqFcJ3i33jPijS7MhGHjtIxaT7Rd
	kcq0P19Q7K6ccj4qXKFgCNLmVx1FfofW57z0UGw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2CX10H8JoVidrLLvG9F8IcYxZO266HV4IEBXliJjxng=:lBVRBzi1HrV2oRlZgNvmYQY5wOEp9ku1L1JFVVgktXQ=;
X-ME-Sender: <xms:nY7zalDO73lc4WFykTNBY7_rQXilAPPtYCi3hDK4wcMytbvGTSY_gg>
    <xme:nY7zanOr_I0PaaUlY1uJjif5C1i0dAt-5ZvfEPN8VrfNrKfHwRpJ8woz-2E-Eggwl
    CBW7V_2kJH7gPawngJfqInsDhuoPIsHt9JVmzNG5sltNnM-i0L5Jb-r>
X-ME-Received: <xmr:nY7zapOfGQYRSjl5D4YETggFGIzYKbvtBW83iye4Kazc5-GrAE2elRIFgssUK7njY3Ow64wKJhGzpxmstw>
X-ME-Proxy-Cause: dmFkZTGNVXlGWE+7P2XXaL26F5AMGtpK2TycDVlf+xOjA+PYERZl6/BW+lbT0+wzTsbcnL
    kBAhJvg1txFwRjOcd7bw7X+tErVQLKyqfU9/T4BbMHT193EbxKvHyY8bAQ6ww6NmZWX2Gj
    S4oVvhJFMJ2BxkJuVf9ujSPSfv16nLGp7k9bwFNTR8UP/etY4ewbE2QpklWLWUkhZbd3tk
    i2NFMM50EyvyBj3i7bkefkHzaAGSTWPc9b/2WlAEfIPv9QAFyLDidETcJqU8/KdZSLuzWm
    YnikjaxRN8sYTqzmqmhrte8FXDDjJZwMnUc/kh6WLuGF7iefMNEW49vFlHrDG5ZIu0qxd+
    D9vO3Bw4CT2UljGjG7FJWzQUcbDN5uNRik9Y7KEgJlbaRMK0H6OqShwO0uPXZhzQRqOBcx
    HDS2ncD//RrwFwcGdxuA0OehwpJqUbR47QXYANZZLI52ra+xJkcEnd8QubtW6wn+aXThZA
    GJVmjVI65mNH4XtuDybr6dte3omr/+b0SHLg06a+0Q8fUOpDuFGJs3Spr3d9MYUyWk9LRc
    Ro1YkdIMoQ/wz55+nLCkHhP4QLdDCjA9LPffTuiez0R9PxXSvL0DCGZNKQM0kqYx7nl6CA
    RT3C36a865oywJ0cc12qZtpAI8jRTB2BMB3yVkyuIg9utQYWA3EJ/ha6b4jw
X-ME-Proxy: <xmx:nY7zahJLS2TIUV3aJPAejjG1y6YVpO7ZAIuRdXyxsjnuWPdVl-dgeg>
    <xmx:nY7zarqqg0kNosLfmf7aZPAJ6M9EmpRLDRIMaSfFnA8mr0lM6ysNCQ>
    <xmx:nY7zalMMCebesuQS66oBZZAf2A8_7lB9wlGbZY9bRqyrSELZBD2F-g>
    <xmx:nY7zashk7EvZ9_U85VbuiIwum2xxFoxGwqApoHmdtBef4RRrqJ1_sg>
    <xmx:nY7zai-hwiVsOiUZWeUh7KLEJnb9iXPW7FSUW4yz9foBE8KkkS_SEE2P>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 16:37:32 -0500 (EST)
From: Juanlu Herrero <juanlu@fastmail.com>
Date: Tue, 10 Nov 2026 13:36:47 -0800
Subject: [PATCH 1/3] selftests: net: make iou-zcrx area size configurable
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-zcrx-dma-debug-registration-v1-1-48743ea61631@fastmail.com>
References: <20261110-zcrx-dma-debug-registration-v1-0-48743ea61631@fastmail.com>
In-Reply-To: <20261110-zcrx-dma-debug-registration-v1-0-48743ea61631@fastmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Juanlu Herrero <juanlu@fastmail.com>
X-Mailer: b4 0.13.0

Add an -a option for selecting the area size in pages while keeping
8192 pages as the default. Combined with -d option, it allows
registration testing without running traffic.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 33 ++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 91b025a8771e1..652b076d10fd5 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <assert.h>
+#include <ctype.h>
 #include <errno.h>
 #include <error.h>
 #include <fcntl.h>
@@ -59,7 +60,7 @@ struct t_io_uring_zcrx_ifq_reg {
 };
 
 static long page_size;
-#define AREA_SIZE (8192 * page_size)
+#define AREA_SIZE (cfg_area_pages * page_size)
 #define SEND_SIZE (512 * 4096)
 #define min(a, b) \
 	({ \
@@ -88,6 +89,7 @@ static int cfg_send_size = SEND_SIZE;
 static struct sockaddr_in6 cfg_addr;
 static unsigned int cfg_rx_buf_len;
 static bool cfg_dry_run;
+static size_t cfg_area_pages = 8192;
 static int cfg_num_threads = 1;
 
 static char *payload;
@@ -328,6 +330,7 @@ static void *server_worker(void *arg)
 	struct thread_ctx *ctx = arg;
 	uint64_t tstop;
 	int nr_conns;
+	int ret;
 	int i;
 
 	params.flags |= IORING_SETUP_COOP_TASKRUN;
@@ -336,9 +339,12 @@ static void *server_worker(void *arg)
 	params.flags |= IORING_SETUP_SUBMIT_ALL;
 	params.flags |= IORING_SETUP_CQE32;
 	params.flags |= IORING_SETUP_CQSIZE;
+	params.flags |= IORING_SETUP_CLAMP;
 	params.cq_entries = AREA_SIZE / page_size;
 
-	io_uring_queue_init_params(512, &ctx->ring, &params);
+	ret = io_uring_queue_init_params(512, &ctx->ring, &params);
+	if (ret)
+		error(1, -ret, "io_uring_queue_init_params()");
 	setup_zcrx(ctx);
 
 	if (cfg_dry_run)
@@ -574,9 +580,10 @@ static void run_client(void)
 
 static void usage(const char *filepath)
 {
-	error(1, 0, "Usage: %s (-4|-6) (-s|-c) -h<server_ip> -p<port> "
-		    "-l<payload_size> -i<ifname> -q<rxq_id> -t<num_threads>",
-		    filepath);
+	error(1, 0, "Usage: %s %s %s %s", filepath,
+	      "(-s|-c) -h<server_ip> -p<port>",
+	      "-l<payload_size> -i<ifname> -q<rxq_id>",
+	      "-t<num_threads> [-a<pages>] [-d]");
 }
 
 static void parse_opts(int argc, char **argv)
@@ -594,7 +601,7 @@ static void parse_opts(int argc, char **argv)
 		usage(argv[0]);
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:dt:")) != -1) {
+	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:a:dt:")) != -1) {
 		switch (c) {
 		case 's':
 			if (cfg_client)
@@ -632,6 +639,20 @@ static void parse_opts(int argc, char **argv)
 		case 'x':
 			cfg_rx_buf_len = page_size * strtoul(optarg, NULL, 0);
 			break;
+		case 'a': {
+			char *end;
+			unsigned long long area_pages;
+
+			errno = 0;
+			area_pages = strtoull(optarg, &end, 0);
+			if (!isdigit((unsigned char)optarg[0]) || errno ||
+			    end == optarg || *end || !area_pages ||
+			    area_pages > UINT_MAX ||
+			    area_pages > SIZE_MAX / page_size)
+				error(1, 0, "invalid area page count: %s", optarg);
+			cfg_area_pages = area_pages;
+			break;
+		}
 		case 'd':
 			cfg_dry_run = true;
 			break;

-- 
2.53.0-Meta

