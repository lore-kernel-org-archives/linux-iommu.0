Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA51B583A
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906235; cv=none; b=QatX9Jcxk2AvYgFLAK7cKQF41PyLFfkEwFpZSbMQiWkQ0Rsfzj2botV1N/MMBw5UZ2JIPNi3Ccp/IgHmeWdDHsWgZ0H/gntrzSmtuxcWrgKlBJAWNNI/bD2K7qCMLZOcSPQIA8375lf7SvX1CoY82Sp9acrcRDcnrd+AdLQgzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906235; c=relaxed/simple;
	bh=NJiSXR/2q9k2YAA0gEDwZCqD1aqsLC5sqUDA5CWKQZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFMHsrmbdit+wllAOPf91G7UZJvtxUfsxUFdYs4LxbVv0CA4t9/9ao/tn+5Th7CFP6tRondPRC4+2b/8gzhmFooWgNBRi/pdhNMZ8dGtrX8VdsfSGOkpeQT2FB91sZOrCPe7sZz5YgRxD/pdlGstPYZJIjEpGCBBAEuAnlNbkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhPGVH8b; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhPGVH8b"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f9b364faddso10590135ad.3
        for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906232; x=1719511032; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgI5gEOuAZO9UYkmZKgqrzsmCGfdpvzU4+T+xEGqCGc=;
        b=QhPGVH8bPvhmL8kitab+ihiZ9ePlmTZ2/a39ZlGqbnPRjUgLXZ2yjec7jP5H498BZN
         5dazUWonvXVB+Xcql/Ds5wBqLh75A8PyizenJ4b3+YC4DtF6ZCzIilzSLonZH0DJcSfK
         eSr9L7PdDGA/hU1VlVzA8iX6aFsE3z0250yL3YL4TajEPeHXSwYWX/1nu0JHSZY0NS8a
         NDSLJ6EwNIl12UNeqCobzneoz2eko2ZCxhB0ewDW74yp+ytukt6mr6PBrnZJ4WA6Zg5G
         XzHWA+BdWr7mWktXjw2aDfIFaR+YXmED+vod6xtb+A8b91P/dE6JEUEsZXV0xVwaITIL
         vcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906232; x=1719511032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgI5gEOuAZO9UYkmZKgqrzsmCGfdpvzU4+T+xEGqCGc=;
        b=jPy7ZxAIF6ng1cyQxFDXF6WrlVegW9H/WJFdqG2TDYcaB0rLxzbvrDHvmy1Hc+7KI/
         WmWTBIe3W3UMDsk2JNXMukH2Kq+2O78jrZjNNLPqDgFlY/nmQtP6yFHT8ylQUZrhvEt9
         ROFEfZJ+6H2uJIUSGqr8R32IToAWTh+NpBbD/V7qoZXWqoo9QxNoK8MPsOGPpBZ/qbnd
         Xft1pxbVKqTsLzMlZznqOhz2qoEKhhp1j7khN+jRQwPjFPvVIQ/FYPo+u4iP+drPnDje
         ehLMnJ0mYwz77or/QRS3VXc/TdKseE2aKHwMYEtTBKUjUb96twpiyTpS7Eb9RCWxnsWt
         8uqA==
X-Forwarded-Encrypted: i=1; AJvYcCUwLFmdiQTFZ+ddZCi289i461zLVGMWXefBDm794cTZUDyBEft4wvSx/RZSVmd1D1GJf2Rdof7pOoJxrV2lBv19V/G7PxI=
X-Gm-Message-State: AOJu0YxiJut3o+++K8ugjDGmRDs8EbjGO5ovXnu3cdUp3DZq08I6+K4e
	ianK4R7GUuGL+5tjk4I/l2k4Mhy+Xb4Jh2i8SzvLPc0pDuo246Bh
X-Google-Smtp-Source: AGHT+IELGiFFQYXDLuYwffpBy+2gvOLdiLXmpqp8gF/i2JmFW6wub2L8+md2wz99GOx5tRmisC4VJQ==
X-Received: by 2002:a17:903:2445:b0:1f9:d282:7a28 with SMTP id d9443c01a7336-1f9d2829be3mr19305765ad.41.1718906231479;
        Thu, 20 Jun 2024 10:57:11 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9d0ec7a7asm15684145ad.251.2024.06.20.10.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:10 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Disseldorp <ddiss@suse.de>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Jiri Pirko <jiri@resnulli.us>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Karsten Keil <isdn@linux-pingi.de>,
	Kees Cook <keescook@chromium.org>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oliver Neukum <oneukum@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Rich Felker <dalias@libc.org>,
	Rob Herring <robh@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	GR-QLogic-Storage-Upstream@marvell.com,
	alsa-devel@alsa-project.org,
	ath10k@lists.infradead.org,
	dmaengine@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	netdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 01/40] lib/find: add atomic find_bit() primitives
Date: Thu, 20 Jun 2024 10:56:24 -0700
Message-ID: <20240620175703.605111-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helpers around test_and_{set,clear}_bit() to allow searching for
clear or set bits and flipping them atomically.

Using atomic search primitives allows to implement lockless bitmap
handling where only individual bits are touched by concurrent processes,
and where people have to protect their bitmaps to search for a free
or set bit due to the lack of atomic searching routines.

The typical locking routines may look like this:

	unsigned long alloc_bit()
	{
		unsigned long bit;

		spin_lock(bitmap_lock);
		bit = find_first_zero_bit(bitmap, nbits);
		if (bit < nbits)
			__set_bit(bit, bitmap);
		spin_unlock(bitmap_lock);

		return bit;
	}

	void free_bit(unsigned long bit)
	{
		spin_lock(bitmap_lock);
		__clear_bit(bit, bitmap);
		spin_unlock(bitmap_lock);
	}

Now with atomic find_and_set_bit(), the above can be implemented
lockless, directly by using it and atomic clear_bit().

Patches 36-40 do this in few places in the kernel where the
transition is clear. There is likely more candidates for
refactoring.

The other important case is when people opencode atomic search
or atomic traverse on the maps with the patterns looking like:

	for (idx = 0; idx < nbits; idx++)
		if (test_and_clear_bit(idx, bitmap))
			do_something(idx);

Or like this:

	do {
		bit = find_first_bit(bitmap, nbits);
		if (bit >= nbits)
			return nbits;

	} while (!test_and_clear_bit(bit, bitmap));

	return bit;

In both cases, the opencoded loop may be converted to a single function
or iterator call. Correspondingly:

	for_each_test_and_clear_bit(idx, bitmap, nbits)
		do_something(idx);

Or:
	return find_and_clear_bit(bitmap, nbits);

Obviously, the less routine code people have to write themself, the
less probability to make a mistake.

The new API is not only a handy helpers - it also resolves a non-trivial
issue of using non-atomic find_bit() together with atomic
test_and_{set,clear)_bit().

The trick is that find_bit() implies that the bitmap is a regular
non-volatile piece of memory, and compiler is allowed to use such
optimization techniques like re-fetching memory instead of caching it.

For example, find_first_bit() is implemented like:

      for (idx = 0; idx * BITS_PER_LONG < sz; idx++) {
              val = addr[idx];
              if (val) {
                      sz = min(idx * BITS_PER_LONG + __ffs(val), sz);
                      break;
              }
      }

On register-memory architectures, like x86, compiler may decide to
access memory twice - first time to compare against 0, and second time
to fetch its value to pass it to __ffs().

When running find_first_bit() on volatile memory, the memory may get
changed in-between, and for instance, it may lead to passing 0 to
__ffs(), which is undefined. This is a potentially dangerous call.

find_and_clear_bit() as a wrapper around test_and_clear_bit()
naturally treats underlying bitmap as a volatile memory and prevents
compiler from such optimizations.

Now that KCSAN is catching exactly this type of situations and warns on
undercover memory modifications. We can use it to reveal improper usage
of find_bit(), and convert it to atomic find_and_*_bit() as appropriate.

In some cases concurrent operations with plain find_bit() are acceptable.
For example:

 - two threads running find_*_bit(): safe wrt ffs(0) and returns correct
   value, because underlying bitmap is unchanged;
 - find_next_bit() in parallel with set or clear_bit(), when modifying
   a bit prior to the start bit to search: safe and correct;
 - find_first_bit() in parallel with set_bit(): safe, but may return wrong
   bit number;
 - find_first_zero_bit() in parallel with clear_bit(): same as above.

In last 2 cases find_bit() may not return a correct bit number, but
it may be OK if caller requires any (not exactly the first) set or clear
bit, correspondingly.

In such cases, KCSAN may be safely silenced with data_race(). But in most
cases where KCSAN detects concurrency we should carefully review their
code and likely protect critical sections or switch to atomic
find_and_bit(), as appropriate.

This patch adds the following atomic primitives:

	find_and_set_bit(addr, nbits);
	find_and_set_next_bit(addr, nbits, start);
	...

Here find_and_{set,clear} part refers to the corresponding
test_and_{set,clear}_bit function. Suffixes like _wrap or _lock
derive their semantics from corresponding find() or test() functions.

For brevity, the naming omits the fact that we search for zero bit in
find_and_set, and correspondingly search for set bit in find_and_clear
functions.

The patch also adds iterators with atomic semantics, like
for_each_test_and_set_bit(). Here, the naming rule is to simply prefix
corresponding atomic operation with 'for_each'.

CC: Bart Van Assche <bvanassche@acm.org>
CC: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS                 |   1 +
 include/linux/find.h        |   4 -
 include/linux/find_atomic.h | 324 ++++++++++++++++++++++++++++++++++++
 lib/find_bit.c              |  86 ++++++++++
 4 files changed, 411 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/find_atomic.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b68c8b25bb93..54f37d4f33dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3730,6 +3730,7 @@ F:	include/linux/bitmap-str.h
 F:	include/linux/bitmap.h
 F:	include/linux/bits.h
 F:	include/linux/cpumask.h
+F:	include/linux/find_atomic.h
 F:	include/linux/find.h
 F:	include/linux/nodemask.h
 F:	include/vdso/bits.h
diff --git a/include/linux/find.h b/include/linux/find.h
index 5dfca4225fef..a855f82ab9ad 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -2,10 +2,6 @@
 #ifndef __LINUX_FIND_H_
 #define __LINUX_FIND_H_
 
-#ifndef __LINUX_BITMAP_H
-#error only <linux/bitmap.h> can be included directly
-#endif
-
 #include <linux/bitops.h>
 
 unsigned long _find_next_bit(const unsigned long *addr1, unsigned long nbits,
diff --git a/include/linux/find_atomic.h b/include/linux/find_atomic.h
new file mode 100644
index 000000000000..a9e238f88d0b
--- /dev/null
+++ b/include/linux/find_atomic.h
@@ -0,0 +1,324 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_FIND_ATOMIC_H_
+#define __LINUX_FIND_ATOMIC_H_
+
+#include <linux/bitops.h>
+#include <linux/find.h>
+
+unsigned long _find_and_set_bit(volatile unsigned long *addr, unsigned long nbits);
+unsigned long _find_and_set_next_bit(volatile unsigned long *addr, unsigned long nbits,
+				unsigned long start);
+unsigned long _find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits);
+unsigned long _find_and_set_next_bit_lock(volatile unsigned long *addr, unsigned long nbits,
+					  unsigned long start);
+unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits);
+unsigned long _find_and_clear_next_bit(volatile unsigned long *addr, unsigned long nbits,
+				unsigned long start);
+
+/**
+ * find_and_set_bit - Find a zero bit and set it atomically
+ * @addr: The address to base the search on
+ * @nbits: The bitmap size in bits
+ *
+ * This function is designed to operate in concurrent access environment.
+ *
+ * Because of concurrency and volatile nature of underlying bitmap, it's not
+ * guaranteed that the found bit is the 1st bit in the bitmap. It's also not
+ * guaranteed that if >= @nbits is returned, the bitmap is empty.
+ *
+ * The function does guarantee that if returned value is in range [0 .. @nbits),
+ * the acquired bit belongs to the caller exclusively.
+ *
+ * Returns: found and set bit, or >= @nbits if no bits found
+ */
+static inline
+unsigned long find_and_set_bit(volatile unsigned long *addr, unsigned long nbits)
+{
+	if (small_const_nbits(nbits)) {
+		unsigned long val, ret;
+
+		do {
+			val = *addr | ~GENMASK(nbits - 1, 0);
+			if (val == ~0UL)
+				return nbits;
+			ret = ffz(val);
+		} while (test_and_set_bit(ret, addr));
+
+		return ret;
+	}
+
+	return _find_and_set_bit(addr, nbits);
+}
+
+
+/**
+ * find_and_set_next_bit - Find a zero bit and set it, starting from @offset
+ * @addr: The address to base the search on
+ * @nbits: The bitmap nbits in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * This function is designed to operate in concurrent access environment.
+ *
+ * Because of concurrency and volatile nature of underlying bitmap, it's not
+ * guaranteed that the found bit is the 1st bit in the bitmap, starting from
+ * @offset. It's also not guaranteed that if >= @nbits is returned, the bitmap
+ * is empty.
+ *
+ * The function does guarantee that if returned value is in range [@offset .. @nbits),
+ * the acquired bit belongs to the caller exclusively.
+ *
+ * Returns: found and set bit, or >= @nbits if no bits found
+ */
+static inline
+unsigned long find_and_set_next_bit(volatile unsigned long *addr,
+				    unsigned long nbits, unsigned long offset)
+{
+	if (small_const_nbits(nbits)) {
+		unsigned long val, ret;
+
+		do {
+			val = *addr | ~GENMASK(nbits - 1, offset);
+			if (val == ~0UL)
+				return nbits;
+			ret = ffz(val);
+		} while (test_and_set_bit(ret, addr));
+
+		return ret;
+	}
+
+	return _find_and_set_next_bit(addr, nbits, offset);
+}
+
+/**
+ * find_and_set_bit_wrap - find and set bit starting at @offset, wrapping around zero
+ * @addr: The first address to base the search on
+ * @nbits: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * Returns: the bit number for the next clear bit, or first clear bit up to @offset,
+ * while atomically setting it. If no bits are found, returns >= @nbits.
+ */
+static inline
+unsigned long find_and_set_bit_wrap(volatile unsigned long *addr,
+					unsigned long nbits, unsigned long offset)
+{
+	unsigned long bit = find_and_set_next_bit(addr, nbits, offset);
+
+	if (bit < nbits || offset == 0)
+		return bit;
+
+	bit = find_and_set_bit(addr, offset);
+	return bit < offset ? bit : nbits;
+}
+
+/**
+ * find_and_set_bit_lock - find a zero bit, then set it atomically with lock
+ * @addr: The address to base the search on
+ * @nbits: The bitmap nbits in bits
+ *
+ * This function is designed to operate in concurrent access environment.
+ *
+ * Because of concurrency and volatile nature of underlying bitmap, it's not
+ * guaranteed that the found bit is the 1st bit in the bitmap. It's also not
+ * guaranteed that if >= @nbits is returned, the bitmap is empty.
+ *
+ * The function does guarantee that if returned value is in range [0 .. @nbits),
+ * the acquired bit belongs to the caller exclusively.
+ *
+ * Returns: found and set bit, or >= @nbits if no bits found
+ */
+static inline
+unsigned long find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits)
+{
+	if (small_const_nbits(nbits)) {
+		unsigned long val, ret;
+
+		do {
+			val = *addr | ~GENMASK(nbits - 1, 0);
+			if (val == ~0UL)
+				return nbits;
+			ret = ffz(val);
+		} while (test_and_set_bit_lock(ret, addr));
+
+		return ret;
+	}
+
+	return _find_and_set_bit_lock(addr, nbits);
+}
+
+/**
+ * find_and_set_next_bit_lock - find a zero bit and set it atomically with lock
+ * @addr: The address to base the search on
+ * @nbits: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * This function is designed to operate in concurrent access environment.
+ *
+ * Because of concurrency and volatile nature of underlying bitmap, it's not
+ * guaranteed that the found bit is the 1st bit in the range. It's also not
+ * guaranteed that if >= @nbits is returned, the bitmap is empty.
+ *
+ * The function does guarantee that if returned value is in range [@offset .. @nbits),
+ * the acquired bit belongs to the caller exclusively.
+ *
+ * Returns: found and set bit, or >= @nbits if no bits found
+ */
+static inline
+unsigned long find_and_set_next_bit_lock(volatile unsigned long *addr,
+					 unsigned long nbits, unsigned long offset)
+{
+	if (small_const_nbits(nbits)) {
+		unsigned long val, ret;
+
+		do {
+			val = *addr | ~GENMASK(nbits - 1, offset);
+			if (val == ~0UL)
+				return nbits;
+			ret = ffz(val);
+		} while (test_and_set_bit_lock(ret, addr));
+
+		return ret;
+	}
+
+	return _find_and_set_next_bit_lock(addr, nbits, offset);
+}
+
+/**
+ * find_and_set_bit_wrap_lock - find zero bit starting at @ofset and set it
+ *				with lock, and wrap around zero if nothing found
+ * @addr: The first address to base the search on
+ * @nbits: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * Returns: the bit number for the next set bit, or first set bit up to @offset
+ * If no bits are set, returns >= @nbits.
+ */
+static inline
+unsigned long find_and_set_bit_wrap_lock(volatile unsigned long *addr,
+					unsigned long nbits, unsigned long offset)
+{
+	unsigned long bit = find_and_set_next_bit_lock(addr, nbits, offset);
+
+	if (bit < nbits || offset == 0)
+		return bit;
+
+	bit = find_and_set_bit_lock(addr, offset);
+	return bit < offset ? bit : nbits;
+}
+
+/**
+ * find_and_clear_bit - Find a set bit and clear it atomically
+ * @addr: The address to base the search on
+ * @nbits: The bitmap nbits in bits
+ *
+ * This function is designed to operate in concurrent access environment.
+ *
+ * Because of concurrency and volatile nature of underlying bitmap, it's not
+ * guaranteed that the found bit is the 1st bit in the bitmap. It's also not
+ * guaranteed that if >= @nbits is returned, the bitmap is empty.
+ *
+ * The function does guarantee that if returned value is in range [0 .. @nbits),
+ * the acquired bit belongs to the caller exclusively.
+ *
+ * Returns: found and cleared bit, or >= @nbits if no bits found
+ */
+static inline unsigned long find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits)
+{
+	if (small_const_nbits(nbits)) {
+		unsigned long val, ret;
+
+		do {
+			val = *addr & GENMASK(nbits - 1, 0);
+			if (val == 0)
+				return nbits;
+			ret = __ffs(val);
+		} while (!test_and_clear_bit(ret, addr));
+
+		return ret;
+	}
+
+	return _find_and_clear_bit(addr, nbits);
+}
+
+/**
+ * find_and_clear_next_bit - Find a set bit next after @offset, and clear it atomically
+ * @addr: The address to base the search on
+ * @nbits: The bitmap nbits in bits
+ * @offset: bit offset at which to start searching
+ *
+ * This function is designed to operate in concurrent access environment.
+ *
+ * Because of concurrency and volatile nature of underlying bitmap, it's not
+ * guaranteed that the found bit is the 1st bit in the range It's also not
+ * guaranteed that if >= @nbits is returned, there's no set bits after @offset.
+ *
+ * The function does guarantee that if returned value is in range [@offset .. @nbits),
+ * the acquired bit belongs to the caller exclusively.
+ *
+ * Returns: found and cleared bit, or >= @nbits if no bits found
+ */
+static inline
+unsigned long find_and_clear_next_bit(volatile unsigned long *addr,
+					unsigned long nbits, unsigned long offset)
+{
+	if (small_const_nbits(nbits)) {
+		unsigned long val, ret;
+
+		do {
+			val = *addr & GENMASK(nbits - 1, offset);
+			if (val == 0)
+				return nbits;
+			ret = __ffs(val);
+		} while (!test_and_clear_bit(ret, addr));
+
+		return ret;
+	}
+
+	return _find_and_clear_next_bit(addr, nbits, offset);
+}
+
+/**
+ * __find_and_set_bit - Find a zero bit and set it non-atomically
+ * @addr: The address to base the search on
+ * @nbits: The bitmap size in bits
+ *
+ * A non-atomic version of find_and_set_bit() needed to help writing
+ * common-looking code where atomicity is provided externally.
+ *
+ * Returns: found and set bit, or >= @nbits if no bits found
+ */
+static inline
+unsigned long __find_and_set_bit(unsigned long *addr, unsigned long nbits)
+{
+	unsigned long bit;
+
+	bit = find_first_zero_bit(addr, nbits);
+	if (bit < nbits)
+		__set_bit(bit, addr);
+
+	return bit;
+}
+
+/* same as for_each_set_bit() but atomically clears each found bit */
+#define for_each_test_and_clear_bit(bit, addr, size) \
+	for ((bit) = 0; \
+	     (bit) = find_and_clear_next_bit((addr), (size), (bit)), (bit) < (size); \
+	     (bit)++)
+
+/* same as for_each_set_bit_from() but atomically clears each found bit */
+#define for_each_test_and_clear_bit_from(bit, addr, size) \
+	for (; (bit) = find_and_clear_next_bit((addr), (size), (bit)), (bit) < (size); (bit)++)
+
+/* same as for_each_clear_bit() but atomically sets each found bit */
+#define for_each_test_and_set_bit(bit, addr, size) \
+	for ((bit) = 0; \
+	     (bit) = find_and_set_next_bit((addr), (size), (bit)), (bit) < (size); \
+	     (bit)++)
+
+/* same as for_each_clear_bit_from() but atomically clears each found bit */
+#define for_each_test_and_set_bit_from(bit, addr, size) \
+	for (; \
+	     (bit) = find_and_set_next_bit((addr), (size), (bit)), (bit) < (size); \
+	     (bit)++)
+
+#endif /* __LINUX_FIND_ATOMIC_H_ */
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 0836bb3d76c5..a322abd1e540 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -14,6 +14,7 @@
 
 #include <linux/bitops.h>
 #include <linux/bitmap.h>
+#include <linux/find_atomic.h>
 #include <linux/export.h>
 #include <linux/math.h>
 #include <linux/minmax.h>
@@ -128,6 +129,91 @@ unsigned long _find_first_and_and_bit(const unsigned long *addr1,
 }
 EXPORT_SYMBOL(_find_first_and_and_bit);
 
+unsigned long _find_and_set_bit(volatile unsigned long *addr, unsigned long nbits)
+{
+	unsigned long bit;
+
+	do {
+		bit = FIND_FIRST_BIT(~addr[idx], /* nop */, nbits);
+		if (bit >= nbits)
+			return nbits;
+	} while (test_and_set_bit(bit, addr));
+
+	return bit;
+}
+EXPORT_SYMBOL(_find_and_set_bit);
+
+unsigned long _find_and_set_next_bit(volatile unsigned long *addr,
+				     unsigned long nbits, unsigned long start)
+{
+	unsigned long bit;
+
+	do {
+		bit = FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
+		if (bit >= nbits)
+			return nbits;
+	} while (test_and_set_bit(bit, addr));
+
+	return bit;
+}
+EXPORT_SYMBOL(_find_and_set_next_bit);
+
+unsigned long _find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits)
+{
+	unsigned long bit;
+
+	do {
+		bit = FIND_FIRST_BIT(~addr[idx], /* nop */, nbits);
+		if (bit >= nbits)
+			return nbits;
+	} while (test_and_set_bit_lock(bit, addr));
+
+	return bit;
+}
+EXPORT_SYMBOL(_find_and_set_bit_lock);
+
+unsigned long _find_and_set_next_bit_lock(volatile unsigned long *addr,
+					  unsigned long nbits, unsigned long start)
+{
+	unsigned long bit;
+
+	do {
+		bit = FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
+		if (bit >= nbits)
+			return nbits;
+	} while (test_and_set_bit_lock(bit, addr));
+
+	return bit;
+}
+EXPORT_SYMBOL(_find_and_set_next_bit_lock);
+
+unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits)
+{
+	unsigned long bit;
+
+	do {
+		bit = FIND_FIRST_BIT(addr[idx], /* nop */, nbits);
+		if (bit >= nbits)
+			return nbits;
+	} while (!test_and_clear_bit(bit, addr));
+
+	return bit;
+}
+EXPORT_SYMBOL(_find_and_clear_bit);
+
+unsigned long _find_and_clear_next_bit(volatile unsigned long *addr,
+					unsigned long nbits, unsigned long start)
+{
+	do {
+		start =  FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
+		if (start >= nbits)
+			return nbits;
+	} while (!test_and_clear_bit(start, addr));
+
+	return start;
+}
+EXPORT_SYMBOL(_find_and_clear_next_bit);
+
 #ifndef find_first_zero_bit
 /*
  * Find the first cleared bit in a memory region.
-- 
2.43.0

