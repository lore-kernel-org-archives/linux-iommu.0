From: Brian Yglesias <brian-q63CSc06zXtcTxQF5mAxrd73AeaZ+mosVpNB7YpNyf8@public.gmane.org>
Subject: Three X58 Workstation Motherboards that won't boot with VT-d
	enabled in BIOS and intel_iommu=on w/ Kernel >=4.2.1
Date: Sun, 5 Jun 2016 18:30:17 -0700 (PDT)
Message-ID: <890340602.20775758.1465176617473.JavaMail.zimbra@atlanticdigitalsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

They are the Asus Rampage II Gene, Gigabyte GA-EX58-UD5, and Asus Rampage III Formula.

I didn't expect the first to work, so I purchased the second based on anecdata around the internet, however it would lock very similarly (but not exactly), and also very early on in boot.

Not wanting to get away from LGA1366, a procured the Forumla, and found the same issue as with the Gigabyte.

All boards have the latest BIOS, and the GB board has a beta bios that is most recent and released specifically for vt-d support.

I now believe I may be experiencing this:  https://lists.linuxfoundation.org/pipermail/iommu/2016-April/016836.html
... though I'm not entirely sure.

This is what the crash looks like on the Forumula:
http://pasteboard.co/1t7wuiz7.jpg
http://pasteboard.co/1t82azKn.jpg
Hope that is helpful.

Unfortunately, the distro/version (Proxmox/4) I'm using is prerequisite for my purposes, and I can't go earlier than 4.2.X.

Any help is much appreciated.
