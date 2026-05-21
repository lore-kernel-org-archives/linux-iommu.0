Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5C394463
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350574; cv=none; b=iQ/tVc52VRmngZRKUr0wP26t2l69+D69Mh0hpdDD7Rt0HBP2wl8/vi5FbblJid+/Eksneje1KYR0GmQ6yMuhyr9gkhSFVpL5Wc585wfCYjo8yjYTvIDhTcj7MUSlBCaPARUV7VzC5yBMjPhXevb1BvfDBoCgAuIAbZ7gM2CJ76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350574; c=relaxed/simple;
	bh=XopIfy/kEYh2vczY8EAIWP6EbEajWhCz0/uq1qVezeA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=hYsCW+RWLm97Sx2oJR85u3se4L8hQsf2yLNk7bBj5EK4qxIym99Cvg97VVEZsex6E6HRn2/qfgzoByzp9HBGcKPyngyznDps82X/sqkLoLFmwYBTWUdNtzCv9DtEMaXuxA+4JCU9TLWjD2VKI+ZguK2am/fBOxzNs5LFK7zHGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XOUmJ//w; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XOUmJ//w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1779350566; bh=9yn6BjrfQEzAJmH8O7zY2U0oFiIi3UdJV0Pa8kBAhPM=;
	h=From:To:Cc:Subject:Date;
	b=XOUmJ//wX95VrIvxc0oRlxH7ACZg1JOru9Lb3oUDVbEYg90zNqEB23u0L9GYBxwEC
	 y25ZdPTrlES6afwF/IYCK0x6Jig0W2BbB+QJUrBwTcwGJa1IQwg8SERs2A7jIHFu5e
	 bvLAUnTHjN+ZciG5od888aX/i6lYbSSUX0pEoNZ0=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id AC1062B; Thu, 21 May 2026 16:02:44 +0800
X-QQ-mid: xmsmtpt1779350564ti9r2qbvh
Message-ID: <tencent_E7BC2E2BDB10173E11B0FD519A84D414E509@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLNA/W4/89YKEl8/8YFL/VPWhMivBRSFz4QRcyNN9rZ+aJKkPgCi
	 I87MPAVyoASCQGeShqPc+Umb70Y5KxyZ2Kwg6DXvm1uoP5VQeEWvTlQN+2R6qTvHfpJGxcUkzehN
	 zfXmSFqFy+ifyZySy4eEhf3cLFzYBpz3o74K1OXvTih0gfp8409+Exs4/6lH+t9tairFYmUW2F05
	 +S57A1ZMmrrmYK1UlPltI9KI1zgETzVgoC+XPeACsPDgF0ariRF1VlmRGUr51Vcn+iulUEpq3Me9
	 S9+FyZPFoD1ycxnDtsBYLE6vc1Mrf51y83feUk8Te+JaGMhRZCUHD1eMgk6FHnudZV0E1Tbx3dkY
	 +toyh9UZRuh68dsWBS7FbolfzI5a3ffsBsLlxhrYJCJNYP9uakCw9TYQU/Jg+UjKdRKI95JOZd1O
	 69poldz3O9+AE9DZjm526Iz5+UobdL5fRPs/C2zJk8uMftxixXrOdSK6iYa1utun5LRgJFwb5RhY
	 VTc9tsoDkVYkJmU3BOEeN5OjTtVHApXeLR0GOprP+heS6D80lyOeCDnRKtxMhxxZDZRcs1W095q2
	 GHN8/evGHIXYJUeoyeoQ4+D9HrMSoFRRqMIRPBIhcCn0mTmqVqwb2qjuRbwBtv9kX5aRajpe2ncz
	 5nfa1Ea34dpNiRW+Ma/95rppJCdsZEOTqPUhDPdujSIJaaq0M6FJ+PHN8V6FjEO1IcSXNyKUtGAa
	 +k+1poiq5zTJopiNacPZkUiuLTxEFb6KhQlL2Dt3X4juXydwyPi4qP9AR0FQa9L6B4J2hg/A37cM
	 4h7Hgw0L+HkP5FrAuE5J8LGaB92JCg+Q8gwxdZa27SHzEzZBUDpweo/T8LzB4LGNz+TpkhoGm86r
	 MMuPN/YJAFfNvv3VJsf5PrbaNmefAuhm/2DPPdJVOkzVmePE7vb5xPMezP8IwdHQVoUqWSd5QArT
	 1YAhgWBhZys0DoQhKVm78E13zvhwxm4g6ppxoDcco=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: 2564278112@qq.com
To: Barry Song <baohua@kernel.org>,
	Qinxin Xia <xiaqinxin@huawei.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Wang Jiang <jiangwang@kylinos.cn>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma/dma_map_benchmark: fix fd leak on error and exit
Date: Thu, 21 May 2026 16:02:41 +0800
X-OQ-MSGID: <20260521080241.528338-1-2564278112@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Jiang <jiangwang@kylinos.cn>

Close the file descriptor when ioctl fails and on normal exit
to fix file descriptor leak.

Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
---
 tools/dma/dma_map_benchmark.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/dma/dma_map_benchmark.c b/tools/dma/dma_map_benchmark.c
index eab0ac611a23..bdb8a837f020 100644
--- a/tools/dma/dma_map_benchmark.c
+++ b/tools/dma/dma_map_benchmark.c
@@ -130,6 +130,7 @@ int main(int argc, char **argv)
 
 	if (ioctl(fd, cmd, &map)) {
 		perror("ioctl");
+		close(fd);
 		exit(1);
 	}
 
@@ -140,5 +141,6 @@ int main(int argc, char **argv)
 	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
 			map.avg_unmap_100ns/10.0, map.unmap_stddev/10.0);
 
+	close(fd);
 	return 0;
 }
-- 
2.25.1

