From: JapHack <japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Problem with ethernet/sound with IOMMU enabled on M5A99FX pro r2.0
	motherboard
Date: Tue, 5 Mar 2013 11:10:52 -0800 (PST)
Message-ID: <1362510652.3171.YahooMailClassic@web120705.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0147819628539980865=="
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

--===============0147819628539980865==
Content-Type: multipart/alternative; boundary="1929490892-2032853565-1362510652=:3171"

--1929490892-2032853565-1362510652=:3171
Content-Type: text/plain; charset=us-ascii

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

--1929490892-2032853565-1362510652=:3171
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">I recently bought this board as I wanted to start doing pci passthrough emulation.<br><br>I noticed that after I had installed it and booted up, with IOMMU enabled<br>the network would work fine for a while then I would get an AMD-Vi IO page fault <br>and the driver would crash. <br>IF I turn off IOMMU there is no problem with using ethernet,<br><br>The onboard ethernet chip is a RTL8111F/8168F.<br>For now I've turned off the network adapter in the bios and am using an add on card.<br><br>Then I noticed that I could not use the onboard audio with oss (4.2.2007) with IOMMU<br>enabled. Alsa works ok, but I prefer to use oss. As with the ethernet card if I turn off<br>IOMMU in the bios the onboard a
 udio is recognized and works fine.<br><br>Any clues or help would be appreciated<br>Thanks, Don<br></td></tr></table>
--1929490892-2032853565-1362510652=:3171--

--===============0147819628539980865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0147819628539980865==--
