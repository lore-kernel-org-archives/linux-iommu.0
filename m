Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422651841
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 06:19:57 +0000 (UTC)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4QCL3B2m0dz1DsQ
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 14:13:26 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.36.20.94])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4QCL2j1VMzzBRQ7w
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 14:13:01 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxus.zte.com.cn (FangMail) with ESMTPS id 4QCL2Y1rldz9wn6p
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 14:12:53 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QCL2N02z5z5B14q;
	Fri,  5 May 2023 14:12:44 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 3456Cbab063060;
	Fri, 5 May 2023 14:12:37 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Fri, 5 May 2023 14:12:39 +0800 (CST)
Date: Fri, 5 May 2023 14:12:39 +0800 (CST)
X-Zmail-TransId: 2afa64549e57ffffffff917-7d156
X-Mailer: Zmail v1.0
Message-ID: <202305051412396252364@zte.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <jgg@ziepe.ca>
Cc: <kevin.tian@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpb21tdWZkL3NlbGZ0ZXN0OiBVc2UgZmRnZXQoKSBhbmQgZmRwdXQoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 3456Cbab063060
X-FangMail-Miltered: at esgde01-2.novalocal with ID 64549E6C.000 by FangMail milter!
X-FangMail-Envelope: 1683267181/4QCL2j1VMzzBRQ7w/64549E6C.000/10.36.20.94/[10.36.20.94]/mxus.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64549E85.000/4QCL3B2m0dz1DsQ

From: Ye Xingchen <ye.xingchen@zte.com.cn>

convert the fget()/fput() uses to fdget()/fdput().

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/iommu/iommufd/selftest.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 74c2076105d4..d3512fa673a5 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -583,17 +583,16 @@ static const struct file_operations iommfd_test_staccess_fops;

 static struct selftest_access *iommufd_access_get(int fd)
 {
-	struct file *file;
+	struct fd f = fdget(fd);

-	file = fget(fd);
-	if (!file)
+	if (!f.file)
 		return ERR_PTR(-EBADFD);

-	if (file->f_op != &iommfd_test_staccess_fops) {
-		fput(file);
+	if (f.file->f_op != &iommfd_test_staccess_fops) {
+		fdput(f);
 		return ERR_PTR(-EBADFD);
 	}
-	return file->private_data;
+	return f.file->private_data;
 }

 static void iommufd_test_access_unmap(void *data, unsigned long iova,
-- 
2.25.1
