From: Donald Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Problem with ethernet/sound with IOMMU enabled on M5A99FX pro
	r2.0	motherboard
Date: Wed, 6 Mar 2013 14:08:57 -0500 (EST)
Message-ID: <2004654126.1428743.1362596937686.JavaMail.root@redhat.com>
References: <1362510652.3171.YahooMailClassic@web120705.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1362510652.3171.YahooMailClassic-s6rE+/zRgQruQS8rMknbopOW+3bF1jUfVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: JapHack <japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Probably a missing IVMD block for the sound device.

The ethernet device issue could be a driver issue -- 
DMA write to a page that was mapped for read-only.
Providing the IO page fault message would help to
diagnose further.

- DonD

----- Original Message -----
From: "JapHack" <japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sent: Tuesday, March 5, 2013 2:10:52 PM
Subject: Problem with ethernet/sound with IOMMU enabled on M5A99FX pro r2.0	motherboard


I recently bought this board as I wanted to start doing pci passthrough emulation. 

I noticed that after I had installed it and booted up, with IOMMU enabled 
the network would work fine for a while then I would get an AMD-Vi IO page fault 
and the driver would crash. 
IF I turn off IOMMU there is no problem with using ethernet, 

The onboard ethernet chip is a RTL8111F/8168F. 
For now I've turned off the network adapter in the bios and am using an add on card. 

Then I noticed that I could not use the onboard audio with oss (4.2.2007) with IOMMU 
enabled. Alsa works ok, but I prefer to use oss. As with the ethernet card if I turn off 
IOMMU in the bios the onboard audio is recognized and works fine. 

Any clues or help would be appreciated 
Thanks, Don 

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
