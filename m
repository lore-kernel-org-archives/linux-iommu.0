Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0382E54C8;
	Wed, 23 Jul 2025 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272684; cv=none; b=aibgOLE+lOYYBM5I3qmBv+DjT7CT0d0UVVOq0y29K1BRTpu010krJvin1WjSeRTjcrqufb1aO1wZr8chy7ui/AVlx+CCXOx9qHmcW4zEVv0raLSoJ7FuH+l6CxsiiTh1RJkbNiFrrMROCaSOEncPEV637Tp4GywWy+GmQ+WvusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272684; c=relaxed/simple;
	bh=QUsyPbnx9eydbxDJV89nCvvANxr9E9edLwebhaDnNoQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Az4R399mvTjPva41Q5t9QI3lrWh82gTFth4f1fw2/mBiKz361WJm2hKOCA6BePZd5ksLAbR/WLOjtsjy7QOZfHMoSYV31HwSSf9VcTxsCjRhjdHCcSDN59i9Bh5bOsuzYp6waU88Yg4X6xVWVcs3KSlMRruFEMblq+mQtkTJ+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l7hNCRqx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l7hNCRqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8D2C4CEE7;
	Wed, 23 Jul 2025 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753272683;
	bh=QUsyPbnx9eydbxDJV89nCvvANxr9E9edLwebhaDnNoQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=l7hNCRqxlIdn3lI4WE07pIB85tFH14GxFlBQpQMQO8ZynXfga5+2+EasEcgyTc/vI
	 pNXjxl0coj/6GBM8jeNfcRRBs0FfLw7P0wlxmqztc1ZXxXSfWKps0fgzS3msD1Dax5
	 P0IoKCFNl4KcABOdrXjS8XyW+eRR0v5ASa+85pRw=
Subject: Patch "iommu/vt-d: Fix misplaced domain_attached assignment" has been added to the 6.12-stable tree
To: baolu.lu@linux.intel.com,bbaa@bbaa.fun,gregkh@linuxfoundation.org,iommu@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 23 Jul 2025 14:11:20 +0200
In-Reply-To: <468CF4B655888074+20250723120423.37924-1-bbaa@bbaa.fun>
Message-ID: <2025072320-delirium-venture-80d8@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    iommu/vt-d: Fix misplaced domain_attached assignment

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iommu-vt-d-fix-misplaced-domain_attached-assignment.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From bbaa@bbaa.fun  Wed Jul 23 14:10:01 2025
From: Ban ZuoXiang <bbaa@bbaa.fun>
Date: Wed, 23 Jul 2025 20:04:23 +0800
Subject: iommu/vt-d: Fix misplaced domain_attached assignment
To: stable@vger.kernel.org
Cc: iommu@lists.linux.dev, baolu.lu@linux.intel.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Ban ZuoXiang <bbaa@bbaa.fun>
Message-ID: <468CF4B655888074+20250723120423.37924-1-bbaa@bbaa.fun>

From: Ban ZuoXiang <bbaa@bbaa.fun>

Commit fb5873b779dd ("iommu/vt-d: Restore context entry setup order
for aliased devices") was incorrectly backported: the domain_attached
assignment was mistakenly placed in device_set_dirty_tracking()
instead of original identity_domain_attach_dev().

Fix this by moving the assignment to the correct function as in the
original commit.

Fixes: fb5873b779dd ("iommu/vt-d: Restore context entry setup order for aliased devices")
Closes: https://lore.kernel.org/linux-iommu/721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun/
Cc: stable@vger.kernel.org
Reported-by: Ban ZuoXiang <bbaa@bbaa.fun>
Signed-off-by: Ban ZuoXiang <bbaa@bbaa.fun>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel/iommu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4414,9 +4414,6 @@ static int device_set_dirty_tracking(str
 			break;
 	}
 
-	if (!ret)
-		info->domain_attached = true;
-
 	return ret;
 }
 
@@ -4600,6 +4597,9 @@ static int identity_domain_attach_dev(st
 		ret = device_setup_pass_through(dev);
 	}
 
+	if (!ret)
+		info->domain_attached = true;
+
 	return ret;
 }
 


Patches currently in stable-queue which might be from bbaa@bbaa.fun are

queue-6.12/iommu-vt-d-fix-misplaced-domain_attached-assignment.patch
