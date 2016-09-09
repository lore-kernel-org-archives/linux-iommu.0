From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Stability connection problems in ath9k kernel 4.7
Date: Fri, 9 Sep 2016 10:38:32 +0200
Message-ID: <20160909083832.GX1437@8bytes.org>
References: <1798564.U2X6r5Zons@automatix> <87wpio155z.fsf@purkki.adurom.net>
	<2596121.7secQ7hYiJ@automatix>
	<87d1kes3qe.fsf@kamboji.qca.qualcomm.com>
	<CAC6K2=_Hdkgc_6igoC59J_Cn9=bdye827zbEK7PWtZY6ebh-6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC6K2=_Hdkgc_6igoC59J_Cn9=bdye827zbEK7PWtZY6ebh-6Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Valerio Passini <valerio.passini-vbqOIlEVYMdeoWH0uzbU5w@public.gmane.org>
Cc: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Valerio,

On Thu, Sep 08, 2016 at 09:07:56PM +0200, Valerio Passini wrote:
> I'm hoping having done it right and I can try your first suggestion, but I
> really cannot solve this problem by myself: sorry, I have no capabilities in
> programming in any known and unknown computer language. Surely, I can test all
> the patches you want and report the results but this is the best I can do. Best
> regards

Can you please send me the full dmesg after boot? The Intel-IOMMU is not
enabled by default, so I want to check if it is either enabled by
kernel-config or kernel command-line.

Thanks,

	Joerg
