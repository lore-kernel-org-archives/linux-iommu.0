From: JapHack <japhack-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Problem with ethernet/sound with IOMMU enabled on M5A99FX pro
	r2.0 motherboard
Date: Wed, 6 Mar 2013 11:08:37 -0800 (PST)
Message-ID: <1362596917.80438.YahooMailClassic@web120705.mail.ne1.yahoo.com>
References: <mailman.31.1362571204.23913.iommu@lists.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5737218134763236074=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <mailman.31.1362571204.23913.iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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

--===============5737218134763236074==
Content-Type: multipart/alternative; boundary="1929490892-475056557-1362596917=:80438"

--1929490892-475056557-1362596917=:80438
Content-Type: text/plain; charset=us-ascii

I tried many setting on various config entries and finally found reference to using "iommu=pt" on the command line and it is working, at least for sound. I'll try the ethernet later to see if that problem is fixed.

Thanks, Don

--1929490892-475056557-1362596917=:80438
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">I tried many setting on various config entries and finally found reference to using "iommu=pt" on the command line and it is working, at least for sound. I'll try the ethernet later to see if that problem is fixed.<br><br>Thanks, Don<br></td></tr></table>
--1929490892-475056557-1362596917=:80438--

--===============5737218134763236074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5737218134763236074==--
