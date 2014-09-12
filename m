From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: ath9k and AMD IOMMU alias breakage on 3.16?
Date: Fri, 12 Sep 2014 18:17:52 +0200
Message-ID: <20140912161752.GV28786@8bytes.org>
References: <CAGou9MhCmRajqfh91rxbBUr9PBvJxo7U=g9p4Onp0pJk4BwBnA@mail.gmail.com>
	<1409976104.2982.56.camel@ul30vt.home>
	<CAGou9Mg+5GhUUECM4qurF6UzhLMARgeCtbL020U9y0Vs7aFGoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGou9Mg+5GhUUECM4qurF6UzhLMARgeCtbL020U9y0Vs7aFGoA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jason Newton <nevion-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jason,

On Fri, Sep 05, 2014 at 10:28:01PM -0700, Jason Newton wrote:
> [    0.021820] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b8 info 0000
> [    0.021827] AMD-Vi:        mmio-addr: 00000000feb80000
> [    0.021844] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:01.0 flags: 00
> [    0.021848] AMD-Vi:   DEV_RANGE_END		 devid: ff:1f.6
> [    0.022730] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 02:00.0 flags: 00 devid_to: 00:14.4
> [    0.022735] AMD-Vi:   DEV_RANGE_END		 devid: 02:1f.7
> [    0.022745] AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 00:14.0
> [    0.022749] AMD-Vi:   DEV_SPECIAL(IOAPIC[5])		devid: 00:14.0
> [    0.022753] AMD-Vi:   DEV_SPECIAL(IOAPIC[6])		devid: 00:00.0

It is just a test, as I don't know how the hardware is actually wired in
your system, but can you try to boot with 'ivrs_ioapic[6]=00:00.1' on
the kernel command line and report if it makes any difference?

Thanks,

	Joerg
