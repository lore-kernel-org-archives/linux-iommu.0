From: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH -stable] amd_iommu: attach device fails on the last pci
	device
Date: Fri, 12 Oct 2012 12:44:50 -0600
Message-ID: <1350067490.4627.8.camel@lorien2>
References: <1350059367.2643.17.camel@lorien2>
	<20121012183828.GA16453@elie.Belkin>
Reply-To: shuah.khan-VXdhtT5mjnY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121012183828.GA16453-fcEM2ccDkbL2nhBuCrrZHw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2012-10-12 at 11:38 -0700, Jonathan Nieder wrote:
> Shuah Khan wrote:
> 
> > This bug is in linux-2.6.32 and an equivalent fix in linux-2.6.33 and has been
> > carried forward to later kernels and is in the upstream kernel. This equivalent
> > fix includes restructuring and consolidating device checks into a routine
> > check_device(). Instead of back-porting all of that work, spot-fixed the bug in
> > amd_iommu_attach_device() for linux-2.6.32.
> 
> To save Willy time: am I correct in guessing the upstream commit you
> are referring to is 98fc5a693bbdda498a556654c70d1e31a186c988
> (x86/amd-iommu: Use get_device_id and check_device where appropriate,
> 2009-11-24)?

Yes that is one. I looked that up again and it has the change to
amd_iommu_attach_device() to use check_device() and removes the check 

-	if (devid >= amd_iommu_last_bdf ||
-			devid != amd_iommu_alias_table[devid])
-		return -EINVAL;
+	devid = get_device_id(dev);

Ref: http://www.spinics.net/lists/linux-tip-commits/msg06129.html


Thanks,
-- Shuah
